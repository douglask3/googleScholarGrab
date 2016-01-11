MakePublicationDocument <-
    function(usr = c('Douglas Kelley' = 'AJKyfI4AAAAJ'), addUserInfo = TRUE,
             header = '', cnameExtra = '',
             cnameFormat = c('<h3>', '</h3>'), pubSep = '<hr>',
             titleFormat = c('<h2>', '</h2>'), citeFormat  = c('', ''),
             yearFormat  = c('', ''), textFormat  = c('', ''), footer = '',
             outputFile  = "outfile.txt", pubid = NULL) {

    library('scholar')

    if (addUserInfo) {
        profile = get_profile('AJKyfI4AAAAJ')
        profile = c('\n',
                    '|Total Citations:|', profile$total_cites,'|\n',
                    '|---|---|\n',
                    '|H index:|', profile$h_index, '|\n',
                    '|i10 index:|', profile$i10_index, '|\n\n')
        profile = paste(profile, collapse = ' ')

    }  else profile = ''

    pubs  = get_publications(usr)
    if (!is.null(pubid)) {
        pubid = apply(sapply(pubid, '==', pubs$pubid), 1, any)
        if (!any(pubid)) warning('no publications found')
        pubs = pubs[pubid,]
    }

    npubs = nrow(pubs)

    out = '\n|'

    addColName <- function(txt)
        paste(out, cnameExtra, cnameFormat[1], txt, cnameFormat[2], '|')

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

    out = addColName('')
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
    cite = c('Generated using scholar package:\n',
               cite$author$family, ',', cite$author$given, '(', cite$year, '),',
               cite$title, ',', cite$note, ',', cite$url)

    if (!is.null(names(usr))) {
        name = c('<a href="https://scholar.google.co.uk/citations?user=',
                            usr, '&hl">',
                 names(usr), '</a> on')
    } else name = ''

    sch = c('extracted from', name,
            '<a href="https://scholar.google.co.uk/">google scholar</a>')


    cite = paste(cite, collapse = ' ')
    sch  = paste(sch, collapse = ' ')
    out = paste(c(header, profile, out, cite, sch, footer), collapse ='\n')

    cat(out, file=outputFile,sep="\n")

}



# Example
class = "publication"
header = 'Title: Publications
Date: 2015-10-01 16:31
Category: Research
status: published

<hr class="title">
    <h1 align="center"> Publication List </h1>
<hr class="title">
'

cnameExtra  = '<hr> &nbsp;'
cnameFormat = c('&nbsp; <h3 class = "publication">', '</h3> &nbsp;')
pubSep      = '<hr>'
titleFormat = c('<h3 class = "publication">', '</h3>')
citeFormat  = c('&nbsp;', '')
yearFormat  = c('&nbsp;', '')
textFormat  = c('', '')

footer = ''

outputFile = 'yay.md'

MakePublicationDocument(c('Douglas Kelley' = 'AJKyfI4AAAAJ'), TRUE,
                        header, cnameExtra, cnameFormat,
                        pubSep, titleFormat, citeFormat, yearFormat, textFormat,
                        footer, outputFile)
outputFile = 'yay1.md'

MakePublicationDocument(c('Douglas Kelley' = 'AJKyfI4AAAAJ'), TRUE,
                        header, cnameExtra, cnameFormat,
                        pubSep, titleFormat, citeFormat, yearFormat, textFormat,
                        footer, outputFile, 'qjMakFHDy7sC')
outputFile = 'yay2.md'

MakePublicationDocument(c('Douglas Kelley' = 'AJKyfI4AAAAJ'), TRUE,
                        header, cnameExtra, cnameFormat,
                        pubSep, titleFormat, citeFormat, yearFormat, textFormat,
                        footer, outputFile, c('qjMakFHDy7sC', 'UeHWp8X0CEIC'))
