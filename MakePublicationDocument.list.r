#AuthorFormat =  '*',  AuthorTitleSep = ':',
# TitleFormat =  '*', TitleJournalSep = ',',
#JournalFormat =   '',    JornalVolSep = '',
#   VolFormat = '**',      VolYearSep = '',
#  YearFormat = '',


MakePublicationDocument.list <-
    function(usr = c('Douglas Kelley' = 'AJKyfI4AAAAJ'), UserProfileFormat = 'lines',
             header = '',
             newItem = ':',
              entireFormat = '*',
              AuthorFormat =  '',  AuthorTitleSep = ':',
               TitleFormat =  '', TitleJournalSep = ',',
             JournalFormat =  '',    JornalVolSep = '',
                 VolFormat =  '',      VolYearSep = '',
                YearFormat =  '',
             footer = '',
             outputFile  = "outfile.txt",
             pubid = NULL, includeCites = TRUE, ...) {

    library('scholar')
    library('gitBasedProjects')

    profile = ''; profileHead = ''
    if (!is.null(UserProfileFormat)) {
        profile = MakeUserProfile(usr, UserProfileFormat)
        if (UserProfileFormat != 'table') {
            profileHead = profile
            profile = ''
        }
    }

    pubs  = get_publications(usr)
    if (!is.null(pubid)) {
        pubid = apply(sapply(pubid, '==', pubs$pubid), 1, any)
        if (!any(pubid)) warning('no publications found')
        pubs = pubs[pubid,]
    }

    npubs = nrow(pubs)

    out = ''

    for (i in 1:nrow(pubs)) {
        outi = paste(newItem,
                     ' ',  entireFormat,
                           AuthorFormat,      pubs[i,2],    AuthorFormat,   AuthorTitleSep,
                     ' ',   TitleFormat,      pubs[i,1],     TitleFormat,  TitleJournalSep,
                     ' ', JournalFormat,      pubs[i,3],   JournalFormat,    JornalVolSep,
                     ' ',     VolFormat,      pubs[i,4],       VolFormat,      VolYearSep,
                     ' ',    YearFormat, '(', pubs[i,6], ')', YearFormat,
                           entireFormat, sep = '')

        if (includeCites) outi = paste(outi, '. citations:', pubs[i,5], sep = '')
        out = paste(out, '\n', outi)
    }

    cite = citation('scholar')
    cite = c('\n: Generated using scholar packages:<br> ',
               cite$author$family, ',', cite$author$given, '(', cite$year, '),',
               cite$title, ',', cite$note, ',', cite$url,'<br> and <br>',
               '<a href="',gitRemoteURL(),'">','googleScholarGrab', '</a>',
               'version no.', gitVersionNumber())

    if (!is.null(names(usr))) {
        name = c('<a href="https://scholar.google.co.uk/citations?user=',
                            usr, '&hl">',
                 names(usr), "`s</a>")
    } else name = ''

    sch = c('extracted from', name,
            '<a href="https://scholar.google.co.uk/">google scholar</a>',
            'on', format(Sys.time(), "%a %d %b %Y %X"))

    cite = paste(cite, collapse = ' ')
    sch  = paste(sch, collapse = ' ')


    if (header == '') header = NULL
    if (profile == '') profile = NULL
    out = paste(c(header, profile, out, cite, sch, footer), collapse ='\n')

    if (is.null(outputFile)) return(out)

    cat(out, file = outputFile, sep = "\n")
    return(outputFile)

}
