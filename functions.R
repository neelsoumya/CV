# Function to produce very basic table, no lines or headings

baretable <- function(tbl, digits = 0,
                      include.colnames=FALSE, include.rownames=FALSE,
                      hline.after=NULL,
                      size = getOption("xtable.size", NULL),
                      add.to.row =  getOption("xtable.add.to.row", NULL),
                      ...) {
  tbl %>%
    xtable::xtable(digits = digits, ...) %>%
    print(
      include.colnames = include.colnames,
      include.rownames = include.rownames,
      hline.after = hline.after,
      comment = FALSE,
      latex.environments = NULL,
      floating = FALSE,
      size=size,
      add.to.row=add.to.row,
      sanitize.text.function = function(x) {
        x
      }
    )
}


# Create bib file for R packages
# Uses CRAN version if it exists.
# Otherwise uses github version

write_packages_bib <- function(pkglist, file)
{
  fh <- file(file, open = "w+")
  on.exit( if( isOpen(fh) ) close(fh) )
  for(i in seq_along(pkglist))
  {
    bibs <- try(getbibentry(pkglist[i]))
    if("try-error" %in% class(bibs))
      stop(paste("Package not found:",pkglist[i]))
    else {
      cat("\n Writing",pkglist[i])
      writeLines(toBibtex(bibs), fh)
    }
  }
  message(paste("OK\nResults written to",file))
}

# Create bib entry for package pkg (character string).

getbibentry <- function(pkg)
{
  # Grab locally stored package info
  meta <- suppressWarnings(packageDescription(pkg))
  if(!is.list(meta))
    stop("No package info found")

  # Check if CRAN version exists
  cran <- pkgsearch::ps(pkg) %>% filter(package==pkg)
  found <- ifelse(NROW(cran) > 0, cran$package == pkg, FALSE)

  # Grab CRAN info if the package is on CRAN
  if(found) {
    meta$Version <- cran$version
    meta$Year <- lubridate::year(cran$date)
    meta$URL <- paste("https://CRAN.R-project.org/package=",
                   pkg,sep="")
  } else {
    # Grab github info
    if(is.null(meta$URL))
      meta$URL <- paste("https://github.com/",meta$RemoteUsername,
                        "/",meta$RemoteRepo,sep="")
    # Find last github commit
    commits <- gh::gh(paste("GET /repos/",meta$RemoteUsername,"/",meta$RemoteRepo,"/commits",sep=""))
    meta$Year <- substr(commits[1][[1]]$commit$author$date,1,4)
  }

  # Fix any & in title
  meta$Title <- gsub("&","\\\\&",meta$Title)

  # Add J to my name
  meta$Author <- gsub("Rob Hyndman","Rob J Hyndman",meta$Author)

  # Fix Souhaib's name
  meta$Author <- gsub("Ben Taieb", "Ben~Taieb", meta$Author)

  # Replace R Core Team with {R Core Team}
  meta$Author <- gsub("R Core Team","{R Core Team}",meta$Author)

  # Replace AEC
  meta$Author <- gsub("Commonwealth of Australia AEC","{Commonwealth of Australia AEC}",meta$Author)

  # Remove comments in author fields
  meta$Author <- gsub("\\([a-zA-Z0-9\\-\\s,&\\(\\)<>:/\\.]*\\)"," ",meta$Author, perl=TRUE)

  # Turn contributions into note (for demography)
  if(grepl("with contributions", meta$Author)) {
    author_split <- stringr::str_split(meta$Author, "with contributions ")
    meta$Author <- author_split[[1]][1]
    meta$Note <- paste0("with contributions ",author_split[[1]][2])
    meta$Note <- gsub('^\\.|\\.$', '', meta$Note)
    meta$Note <- gsub('(^[a-z])','\\U\\1', meta$Note, perl=TRUE)
  }
  else
    meta$Note <- NULL


  # Create bibentry
  rref <- bibentry(
    bibtype="Manual",
    title=paste(meta$Package,": ",meta$Title, sep=""),
    year=meta$Year,
    author = meta$Author,
    url = strsplit(meta$URL,",")[[1]][1],
    version = meta$Version,
    key = paste("R",meta$Package,sep=""),
    note = meta$Note
  )
  return(rref)
}

# Return vector of package names authored by RJH
# Input is a list of github packages in the form "package/repo"
find_rjh_packages <- function() {
  # First check installed packages
  installed <- c(
      fs::dir_ls("~/R/x86_64-pc-linux-gnu-library/4.0/"),
      fs::dir_ls("/usr/local/lib/R/site-library"),
      fs::dir_ls("/usr/lib/R/site-library")
    ) %>%
    stringr::str_extract("[a-zA-Z0-9\\-\\.]*$") %>%
    tibble::as_tibble() %>%
    rename(package = value) %>%
    mutate(
      meta = map(package, function(x){suppressWarnings(packageDescription(x))}),
      hyndman = map_lgl(meta, function(x){grepl("Hyndman", x$Author, fixed=TRUE)})
    ) %>%
    filter(hyndman) %>%
    pull(package)

  # Now check CRAN packages
  cran <- pkgsearch::ps("Hyndman", size = 100) %>%
    filter(map_lgl(
      package_data, ~ grepl("Hyndman", .x$Author, fixed = TRUE))
    ) %>%
    pull(package)

  # Combine lists
  c(cran,installed) %>% unique() %>% sort()
}


# An Rscript that takes a bib file as input and return a tibble containing
# one row per publication with a column indicating the class: A*, A, B, etc.
# The script should take the refs tibble, and append a column based on the ADBC and ERA lists.


prepare_bib_report <- function(bib_file) {
  fuzzmatch_adbc <- function(x) {
    return(agrep(x, adbc_ranking$Journal.Title, value = TRUE, ignore.case = TRUE))
  }
  fuzzmatch_ERA <- function(x) {
    return(agrep(x, era_ranking$Title, value = TRUE, ignore.case = TRUE))
  }

  best_match <- function(x, y) {
    return(y[which.min(adist(x, y, ignore.case = TRUE))])
  }

  adbc_ranking <- read.csv("abdc2016.csv", header = TRUE)
  era_ranking <- read.csv("era2010.csv", header = TRUE)

  levels(adbc_ranking$ABDC.Rating) <- levels(era_ranking$Rank)

  df <-  ReadBib(bib_file) %>%
    as_tibble() %>%
    mutate(
    	title = stringr::str_remove_all(title, "[{}]"),
      ADBC_ranking = adbc_ranking[match(journal, adbc_ranking$Journal.Title), "ABDC.Rating"],
      ERA_ranking = era_ranking[match(journal, era_ranking$Title), "Rank"],
      Rank = coalesce(ADBC_ranking, ERA_ranking),
      Rank = as.character(fct_explicit_na(Rank, na_level = "None"))
    )

  df1 <- df %>% subset(Rank != "None")

  ### check journal names from adbc_ranking database
  no_matchdf <- df %>%
    subset(Rank == "None") %>%
    mutate(
      journal = fct_explicit_na(journal, na_level = "999999999"),
      journal = as.character(journal)
    )

  out <- sapply(no_matchdf$journal, fuzzmatch_adbc)

  ## select the best match
  i <- lapply(out, function(x) {
    length(x) > 1
  }) %>% unlist(use.names = FALSE)
  out[i] <- sapply(names(out[i]), best_match, y = unlist(out[i], use.names = FALSE))



  indx <- !sapply(out, is_empty)
  no_matchdf <- no_matchdf %>%
    mutate(
      journal = unlist(ifelse(indx, out, journal)),
      ADBC_ranking = adbc_ranking[match(journal, adbc_ranking$Journal.Title), "ABDC.Rating"],
      Rank = ADBC_ranking,
      Rank = as.character(fct_explicit_na(Rank, na_level = "None"))
    )
  df2 <- no_matchdf %>% subset(Rank != "None")

  ### check journal names from ERA_ranking database
  no_match_adbc <- no_matchdf %>% subset(Rank == "None")
  out <- sapply(no_match_adbc$journal, fuzzmatch_ERA)

  ## select the best match
  i <- lapply(out, function(x) {
    length(x) > 1
  }) %>% unlist(use.names = FALSE)
  out[i] <- sapply(names(out[i]), best_match, y = unlist(out[i], use.names = FALSE))

  indx <- !sapply(out, is_empty)
  df3 <- no_match_adbc %>%
    mutate(
      journal = unlist(ifelse(indx, out, journal)),
      ERA_ranking = era_ranking[match(journal, era_ranking$Title), "Rank"],
      Rank = ERA_ranking,
      Rank = as.character(fct_explicit_na(Rank, na_level = "None"))
    )

  bind_rows(df1, df2, df3) %>%
    mutate(
    	journal = ifelse((journal == 999999999), NA, journal),
    	Rank = factor(Rank, levels=c("A*","A","B","C","None"))
    ) %>%
    select(bibtype:year, journal, title, type, ADBC_ranking:Rank, institution, url:pages, doi:school)  %>%
    return()
}