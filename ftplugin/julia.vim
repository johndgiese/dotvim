setlocal makeprg=julia\ %
setlocal errorformat=%C\ in%.%#,
    \%EERROR:\ %m,
    \%Zwhile\ loading\ %f\\,\ %.%#line\ %l,
    \%-G%.%#

