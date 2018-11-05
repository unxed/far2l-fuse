#!/bin/bash
sudo apt-get install git gawk m4 libglib2.0-dev libwxgtk3.0-dev cmake g++ libgtkmm-3.0-dev uuid-dev libssl-dev sshfs gvfs-libs gvfs-backends gvfs-fuse
rm -rf far2l.deb far2l_`getconf LONG_BIT`_tty.deb
rm -rf far2l
mkdir far2l
cd far2l
git clone https://github.com/elfmz/far2l
cd far2l
git checkout backend-separation
git clone https://github.com/cycleg/far-gvfs.git
git clone https://github.com/unxed/far2l-fuse.git
cd ..
echo "add_subdirectory (far-gvfs)" >> far2l/CMakeLists.txt
echo "add_subdirectory (far2l-fuse)" >> far2l/CMakeLists.txt
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ../far2l
make
cd ..
mkdir deb
mkdir deb/far2l
mkdir deb/far2l/DEBIAN
echo "Package: far2l" > deb/far2l/DEBIAN/control
echo "Version: 2.0" >> deb/far2l/DEBIAN/control
MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
    echo "Architecture: amd64" >> deb/far2l/DEBIAN/control
else
    echo "Architecture: i386" >> deb/far2l/DEBIAN/control
fi
echo "Maintainer: root <root@localhost>" >> deb/far2l/DEBIAN/control
echo "Priority: extra" >> deb/far2l/DEBIAN/control
echo "Depends: libglib2.0-dev, libwxgtk3.0-dev, libgtkmm-3.0-dev, uuid-dev, libssl-dev, sshfs, gvfs-libs, gvfs-backends, gvfs-fuse" >> deb/far2l/DEBIAN/control
echo "Description: Linux port of FAR v2" >> deb/far2l/DEBIAN/control
echo " https://github.com/elfmz/far2l" >> deb/far2l/DEBIAN/control
echo " ." >> deb/far2l/DEBIAN/control
echo " License: GNU/GPLv2" >> deb/far2l/DEBIAN/control
echo " ." >> deb/far2l/DEBIAN/control
echo " Used code from projects:" >> deb/far2l/DEBIAN/control
echo " FAR for Windows" >> deb/far2l/DEBIAN/control
echo " Wine" >> deb/far2l/DEBIAN/control
echo " ANSICON" >> deb/far2l/DEBIAN/control
echo " Portable UnRAR" >> deb/far2l/DEBIAN/control
echo " 7z ANSI-C Decoder" >> deb/far2l/DEBIAN/control
echo " ." >> deb/far2l/DEBIAN/control
mkdir deb/far2l/usr
mkdir deb/far2l/usr/bin
mkdir deb/far2l/usr/share
mkdir deb/far2l/usr/share/applications
echo "[Desktop Entry]" > deb/far2l/usr/share/applications/far2l.desktop
echo "Type=Application" >> deb/far2l/usr/share/applications/far2l.desktop
echo "Name=far2l wx" >> deb/far2l/usr/share/applications/far2l.desktop
echo "GenericName=far2l wx" >> deb/far2l/usr/share/applications/far2l.desktop
echo "Comment=File and archieve manager" >> deb/far2l/usr/share/applications/far2l.desktop
echo "Exec=far2l" >> deb/far2l/usr/share/applications/far2l.desktop
echo "Terminal=false" >> deb/far2l/usr/share/applications/far2l.desktop
echo "Categories=Utility;FileManager;" >> deb/far2l/usr/share/applications/far2l.desktop
echo "Icon=far2l.svg" >> deb/far2l/usr/share/applications/far2l.desktop
echo "StartupNotify=true" >> deb/far2l/usr/share/applications/far2l.desktop
#echo "[Desktop Entry]" > deb/far2l/usr/share/applications/far2lс.desktop
#echo "Type=Application" >> deb/far2l/usr/share/applications/far2lс.desktop
#echo "Name=far2l tty" >> deb/far2l/usr/share/applications/far2lс.desktop
#echo "GenericName=far2l tty" >> deb/far2l/usr/share/applications/far2lс.desktop
#echo "Comment=File and archieve manager" >> deb/far2l/usr/share/applications/far2lс.desktop
#echo "Exec=far2l --tty" >> deb/far2l/usr/share/applications/far2lс.desktop
#echo "Terminal=true" >> deb/far2l/usr/share/applications/far2lс.desktop
#echo "Categories=Utility;FileManager;" >> deb/far2l/usr/share/applications/far2lс.desktop
#echo "Icon=far2l.svg" >> deb/far2l/usr/share/applications/far2lс.desktop
mkdir deb/far2l/usr/share
mkdir deb/far2l/usr/share/icons
mkdir deb/far2l/usr/share/icons/hicolor
mkdir deb/far2l/usr/share/icons/hicolor/scalable
mkdir deb/far2l/usr/share/icons/hicolor/scalable/apps
cp far2l/far2l/DE/icons/far2l.svg deb/far2l/usr/share/icons/hicolor/scalable/apps/far2l.svg
mkdir deb/far2l/usr/lib
mkdir deb/far2l/usr/lib/far2l
cp -R build/install/* deb/far2l/usr/lib/far2l/
wget -P deb/far2l/usr/lib/far2l https://github.com/unxed/far2l-deb/raw/master/quirks_common.zip
wget -P deb/far2l/usr/lib/far2l https://github.com/unxed/far2l-deb/raw/master/quirks_far2l_vt.zip
wget -P deb/far2l/usr/lib/far2l/Plugins/colorer/base/hrd/console https://github.com/unxed/far2l-deb/raw/master/eight.hrd
echo $'    <hrd class="console" name="eight" description="Eight">' >> deb/far2l/usr/lib/far2l/Plugins/colorer/base/hrd/catalog-console.xml
echo $'      <location link="&hrd;/console/eight.hrd"/>' >> deb/far2l/usr/lib/far2l/Plugins/colorer/base/hrd/catalog-console.xml
echo $'    </hrd>' >> deb/far2l/usr/lib/far2l/Plugins/colorer/base/hrd/catalog-console.xml
cd deb/far2l/usr/bin/
ln -s ../lib/far2l/far2l far2l
wget https://raw.githubusercontent.com/unxed/far2l-deb/master/far2lc.sh
mv far2lc.sh far2lc
chmod +x far2lc
cd ../../..
fakeroot dpkg-deb --build far2l
cp far2l.deb ../..
cd ../..
rm -rf far2l
mv far2l.deb far2l_`getconf LONG_BIT`_tty.deb
