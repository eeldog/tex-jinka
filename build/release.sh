#! /bin/sh
# - shell script for package release

package=jinka;
version=$(head -1 VERSION | grep -o '[0-9.]*$');
pkgdir="${package}-${version}";

[ -z "$pkgdir" ] && exit 1;
[ -d "$pkgdir" ] && rm -rf "$pkgdir";
mkdir "$pkgdir";

set $(cat MANIFEST);
for file in "$@"; do
  [ -d "$file" ] && continue;
  [ -r "$file" ] && cp -p "$file" "${pkgdir}/${file}";
done

chmod -R a+r "$pkgdir";
tar cvfz "${pkgdir}.tar.gz" "$pkgdir";
rm -rf "$pkgdir";

scp "${pkgdir}.tar.gz" yusuke@bm.hus.osaka-u.ac.jp:public_html/archive/;


exit 0;
