%% summary.cls -- jinka summary class
%% それっぽい人科学位論文要約原稿クラス
%% $Revision: 1.1 $
%% $Date: 2005-02-06 11:25:42 +0900 (Sun, 06 Feb 2005) $
%% Copyright (C) 2002  MIYAMOTO Yusuke

% 日本語 pLaTeX の jarticle に基づく．
\LoadClass[11pt,a4j]{jarticle}

%% 45字/行
%% 40行/頁
\setlength{\textwidth} {45\Chs}
\setlength{\textheight}{40\Cvs}

%% 本文をセンタリング
%% (左右/上下のマージンは 25mm)
\setlength{\oddsidemargin}  {\paperwidth}
\addtolength{\oddsidemargin}{-\textwidth}
\setlength{\oddsidemargin}  {0.5\oddsidemargin}
\addtolength{\oddsidemargin}{-1in}
\setlength{\evensidemargin} {\oddsidemargin}


%% タイトルの設定
% 副題
\providecommand{\subtitle}[1]{\global\edef\@subtitle{#1}}

% タイトルの組版
\renewcommand{\maketitle}{\par
  \begingroup
  \if@twocolumn
    \ifnum\col@number=\@ne \maketitle
    \else \twocolumn[\@maketitle]
    \fi
  \else
    \newpage
    \global\@topnum\z@
    \@maketitle
  \fi
  \thispagestyle{empty}
  \endgroup
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\p@thanks\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\@subtitle\@empty
  \global\let\title\relax
  \global\let\subtitle\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}

\renewcommand{\@maketitle}{
  \newpage\null
  \begin{center}
    {\fontsize{14}{16}\selectfont\@title\par}  % 14pt
    \@ifundefined{@subtitle}
      {\relax}
      {\fontsize{12}{14}\selectfont\@subtitle} % 12pt
  \end{center}
  \begin{flushright}
    {\fontsize{12}{14}\@author}                % 12pt
  \end{flushright}
}

\endinput
