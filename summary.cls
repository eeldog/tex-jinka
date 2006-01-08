%% summary.cls -- jinka summary class
%% それっぽい人科学位論文要約原稿クラス
%% $Revision$
%% $Date$
%% Copyright (c) 2002-2006  MIYAMOTO Yusuke

% 日本語 pLaTeX の jarticle に基づく．
\LoadClass[11pt,a4j]{jarticle}

%% (左右/上下のマージンは 25mm)
\setlength{\voffset}{-1in}
\setlength{\topmargin}{25mm}
\setlength{\headheight}{0pt}
\setlength{\headsep}{0pt}
\setlength{\textheight}{\paperheight}
\addtolength{\textheight}{-\footskip}
\addtolength{\textheight}{-50mm}

\setlength{\hoffset}{-1in}
\setlength{\marginparsep}{0pt}
\setlength{\marginparwidth}{0pt}
\setlength{\oddsidemargin}{25mm}
\setlength{\evensidemargin}{\oddsidemargin}
\setlength{\textwidth}{\paperwidth}
\addtolength{\textwidth}{-2\oddsidemargin}

\AtBeginDocument{%
 \setlength{\baselineskip}{\textheight}
 \addtolength{\baselineskip}{-\topskip}
 \divide\baselineskip by 39}

%% タイトルの設定
% 副題
\let\@subtitle=\@empty
\providecommand{\subtitle}[1]{\global\edef\@subtitle{#1}}

\let\ps@jpl@in\ps@empty
\pagestyle{empty}
% タイトルの組版
\renewcommand{\@maketitle}{
  \newpage
  \begin{center}
    {\fontsize{14}{16}\selectfont\@title\par}  % 14pt
    \@ifundefined{@subtitle}
      {\relax}
      {\fontsize{12}{14}\selectfont\@subtitle\par} % 12pt
  \end{center}
  \vspace{\Cvs}
  \bgroup\hfill
    {\fontsize{12}{14}\selectfont\@author}     % 12pt
  \egroup
  \normalsize\vspace{\Cvs}
}

\endinput
