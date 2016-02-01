
MakePublicationDocument.Rlist <-
    function(usr = c('Douglas Kelley' = 'AJKyfI4AAAAJ'), UserProfileFormat = 'lines',
             pubid = NULL, includeCites = TRUE, dateOrdered = TRUE, ...) {

    library('scholar')
    library('gitBasedProjects')

    pubs  = get_publications(usr)
    if (!is.null(pubid)) {
        pubid = apply(sapply(pubid, '==', pubs$pubid), 1, any)
        if (!any(pubid)) warning('no publications found')
        pubs = pubs[pubid,]
    }
    
    if (dateOrdered) pubs = pubs[sort(pubs[,'year'], TRUE, index.return = TRUE)[[2]],]

    npubs = nrow(pubs)

    makePub <- function(pub)
        pub[c('author', 'title', 'journal', 'number', 'year', 'cites')]

    pubs = apply(pubs,1, makePub)
    pubs = split(as.matrix(pubs), rep(1:ncol(pubs), each = nrow(pubs)))


    cite = citation('scholar')

    cite = paste('Generated using R-package scholar ', cite$note, ' by ', cite$author,
                 ', ', cite$year, ' (<a href ="', cite$url, '">',cite$url, '</a>); and googleScholarGrab version', gitVersionNumber(),
                 ' (<a href = "',gitRemoteURL(),'">', gitRemoteURL()',</a>)', sep = "")

    if (!is.null(names(usr))) {
        name = paste('<a href="https://scholar.google.co.uk/citations?user=',
                            usr, '&hl">',
                 names(usr), "`s</a>", sep = "")
    } else name = ''
    
    cite = paste(cite, '<br>extracted from ', name,
               ' <a href="https://scholar.google.co.uk/">google scholar</a> ',
               'on ', format(Sys.time(), "%a %d %b %Y %X"), sep = "")

    return(c(pubs, cite))

}
