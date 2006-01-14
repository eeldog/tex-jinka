#! /usr/bin/awk -f
##
## checksum.awk - calculate \CheckSum for LaTeX `doc.sty' package.
##

BEGIN { code = 0; bslash = 0; }

/\\begin{macrocode\*?}/, /\\end{macrocode\*?}/ {
    if ( $0 ~ /\\(begin|end){macrocode\*?}/ ) { next; }
    gsub(/\033\$B[^\033]*\033\(B/, "");  # remove JIS Kanji code
    gsub(/[^\\]/, "");
    bslash += length();
};

END { printf( "%% \\CheckSum{%d}\n", bslash ); }

