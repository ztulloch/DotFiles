Spacemacs Cheatsheet
## Getting started
Move current config files .emacs and .emacs.d
```
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
```
Start emacs and select evil mode.
## Vi Basics
* **_i_** - Insert at point
* **_o_** - Insert on newline
* **_A_** - Append at end of line
* **_u_** - Undo
* **_Ctrl-R_** - Redo
* **_._** Repeat last insertion
* **_x_** - delete charater after cursor
* **_X_** - delete charater after cursor
* **_r_** - replace character after cursor
* **_R_** - overwrite mode
* **_dd_** - delete line
* **_dw_** - delete word
* **_D_** - delete to end of line
* **_h j k l_** - move around inside buffer
* **_0_** - jump to start of line
* **_$_** - jump to end of line
* **_J_** - Join next line to current line
* **_xp_** transpose current character with next one
* **_Xp_** transpose current character with previous one
* **_gg_** goto start of buffer
* **_G_** goto end of buffer
* **_yy_** yank line
## General Operation
* **_SPACE q q_** - quit
* **_SPACE f s_** - save buffer
* **_SPACE f S_** or **_:wa_** save all buffers
* **_SPACE f e d_** Open .spacemacs file
* **_SPACE f C d / u_** - convert unix / dos CR LFs
* **_SPACE f E_** - Open file with elevated privileges
* **_SPACE f t_** - toggle file tree
* **_SPACE T n_** - cycle theme
* **_SPACE t E e_** - switch between holy / evil mode
* **_SPACE s c_** - clear search highlight
* **_SPACE t p_** toggle smart parenthesis
* **_SPACE v s (_** or **_ysiw(_** surround current word with parenthesis
* **_SPACE b b_** - buffer menu
* **_SPACE r y_** - show selectable kill ring
## Windows
* **_SPACE 1-9_** - jump to window
* **_SPACE TAB_** - change to previous buffer in current window
* **_SPACE w / or -_** - split horizontally or vertically
## Org Mode
* **_SPACE a o a_** - org agenda mode
* **_SPACE a o #_** - list stuck projects
* **_SPACE a o /_** - search for string
* **_SPACE a o c_** - org capture
* **_SPACE a o l_** - org store link
* **_SPACE m a a_** - agenda command
* **_SPACE a o p_** - projectile capture
* **_SPACE p o_** - goto project file
* **_SPACE m S lkjh_** - move subtree around
* **_SPACE m RET_** insert org tree above cursor 
* **_SPACE m /_** sparse tree 
* **_SPACE m ,_**_ add tags 
* **_SPACE m A_** archive subtree
* **_SPACE m s_** schedule  
* **_SPACE s j_** jump in buffer
* **_SPACE m d_** deadline 
* **_SPACE m R_** org refile in current file
* **_< >_** promote / demote subtree
* **_t_** set TODO
* **_T_** insert TODO tree
## Agenda View
* **_t_** - mark as done
* **_ENTER_** - jump to file
