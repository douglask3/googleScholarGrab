
MakePublicationDocument <-
    function(usr = c('Douglas Kelley' = 'AJKyfI4AAAAJ'), UserProfileFormat = 'lines',
             header = '', cnameExtra = '',
             cnameFormat = c('<h3>', '</h3>'), pubSep = '<hr>',
             titleFormat = c('<h2>', '</h2>'), citeFormat  = c('', ''),
             yearFormat  = c('', ''), textFormat  = c('', ''), footer = '',
             outputFile  = "outfile.txt", pubid = NULL, ...) {

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

    out = '\n|'

    addColName <- function(txt, format = cnameFormat)
        paste(out, cnameExtra, format[1], txt, format[2], '|')

    addCell <- function(format, txt, outi = out)
        paste(outi, format[1], txt, format[2], '|')

    addTxt <- function(txt) {
        out = paste(out,'\n|')
        out = addCell(textFormat , txt, out)
        for (i in 1:2) out = addCell(c('','') , '', out)
        return(out)
    }

    addNewLine <- function() {
        out = paste(out,'\n|')
        out = paste(c(out, rep(paste(pubSep, '|'), 3)), collapse = '')
        out = paste(out,'\n|')
    }

    out = addColName(profileHead, c('',''))
    out = addColName('Cite By')
    out = addColName('Year')
    out = paste(out, '\n|---|---|---|')

    for (i in 1:npubs) {
        out = addNewLine()

        pub = pubs[i, ]

        out = addCell(titleFormat, pub$title)
        out = addCell(citeFormat , pub$cites)
        out = addCell(yearFormat , pub$year )


        out = addTxt(pub$author)
        journal = sapply(pub[c('journal', 'number')], as.character)
        out = addTxt(paste(journal, collapse = ' '))
    }

    out = addNewLine()

    cite = citation('scholar')
    cite = c('Generated using scholar packages:\n',
               cite$author$family, ',', cite$author$given, '(', cite$year, '),',
               cite$title, ',', cite$note, ',', cite$url,'\n and \n',
               '<a href="',gitRemoteURL(),'">','googleScholarGrab', '</a>',
               'version no.', gitVersionNumber())

    if (!is.null(names(usr))) {
        name = c('<a href="https://scholar.google.co.uk/citations?user=',
                            usr, '&hl">',
                 names(usr), "'s</a>")
    } else name = ''

    sch = c('extracted from', name,
            '<a href="https://scholar.google.co.uk/">google scholar</a>',
            'on', format(Sys.time(), "%a %d %b %Y %X"))
            
    cite = paste(cite, collapse = ' ')
    sch  = paste(sch, collapse = ' ')
    out = paste(c(header, profile, out, cite, sch, footer), collapse ='\n')

    cat(out, file=outputFile,sep="\n")

    return(outputFile)

}
