MakeUserProfile <- function(usr, format = '1line') {
    profile = get_profile(usr)

    if (format == 'table') {
        profile = c('\n',
                    '|**Total Citations:**|', profile$total_cites,'|\n',
                    '|---|---|\n',
                    '|**H index:**|', profile$h_index, '|\n',
                    '|**i10 index:**|', profile$i10_index, '|\n\n')
    } else if(format == 'lines') {
        profile = c('**Total Citations:**', profile$total_cites,'<br>',
                    '**H index:**', profile$h_index, '<br>',
                    '**i10 index:**', profile$i10_index)
    }  else {
        profile = c('**Total Citations:**', profile$total_cites,';',
                    '**H index:**', profile$h_index, ';',
                    '**i10 index:**', profile$i10_index)
    }
    profile = paste(profile, collapse = ' ')
    return(profile)
}
