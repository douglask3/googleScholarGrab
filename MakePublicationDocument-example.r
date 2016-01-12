# Example
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

MakePublicationDocument(c('Douglas Kelley' = 'AJKyfI4AAAAJ'), 'lines',
                        header, cnameExtra, cnameFormat,
                        pubSep, titleFormat, citeFormat, yearFormat, textFormat,
                        footer, outputFile)
outputFile = 'yay1.md'

MakePublicationDocument(c('Douglas Kelley' = 'AJKyfI4AAAAJ'), '1line',
                        header, cnameExtra, cnameFormat,
                        pubSep, titleFormat, citeFormat, yearFormat, textFormat,
                        footer, outputFile, 'qjMakFHDy7sC')
outputFile = 'yay2.md'

MakePublicationDocument(c('Douglas Kelley' = 'AJKyfI4AAAAJ'), 'table',
                        header, cnameExtra, cnameFormat,
                        pubSep, titleFormat, citeFormat, yearFormat, textFormat,
                        footer, outputFile, c('qjMakFHDy7sC', 'UeHWp8X0CEIC'))
