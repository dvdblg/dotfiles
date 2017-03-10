**Disclaimer**: Please follow this guide being aware of the fact that I'm not an expert regarding the things outlined below, however I made my best attempt. A few people in IRC confirmed it worked for them and the results looked acceptable.

**Attention**: After following all the steps run `gdk-pixbuf-query-loaders --update-cache` as root, this prevents various gdk-related bugs that have been reported in the last few hours. Symptoms are varied, and for Cinnamon the DE fails to start entirely while for XFCE the icon theme seemingly can't be changed anymore etc.

**Check the gist's comments for any further tips and instructions, especially if you are running into problems!**


Screenshots
===========
Results after following the guide as of 11.01.2017 13:08:

 * [This page](http://i.imgur.com/P6ZFvJn.png)
 * [Linux - Wikipedia](http://i.imgur.com/SM1gH6p.png)
 * [Arch Linux Website](http://i.imgur.com/NgXzDTA.png)
 * [Eevee's Article about Fontconfig](http://i.imgur.com/XH1kUCC.png)


Changelog
=========

* 10.01.2017 23:22: Changed typo `Windings` to `Wingdings` in the [/etc/fonts/local.conf template](https://gist.github.com/cryzed/4f64bb79e80d619866ee0b18ba2d32fc), users are advised to update their files.
* 11.01.2017 00:42: Fixed [another bug](https://gist.github.com/cryzed/e002e7057435f02cc7894b9e748c5671#gistcomment-1967788) in `/etc/fonts/local.conf`, thank you [edgard](https://github.com/edgard).
* 11.01.2017 13:08: Instruct users to symlink configuration from `/etc/fonts/conf.avail` instead of setting interpreter instructions in `/etc/fonts/local.conf`. This prevents the overwriting of specialized fontconfig instructions in lower prefixes and might change the looks slightly. To restore the old behavior you can simply insert:
```xml
  <match target="font">
    <edit name="hintstyle" mode="assign">
      <const>hintslight</const>
    </edit>
  </match>
```
below `<fontconfig>` in `/etc/fonts/local.conf`. Here's the [old look](http://i.imgur.com/8jR9lUI.png) and the [new look](http://i.imgur.com/P6ZFvJn.png), I urge you to test it on more sites to get a feel for the differences. There are advantages and disadvantages to both, though in general I feel that the new look preserves more of the actual shape.

* 11.01.2017 15:22: Added some screenshots at the very top of the gist.
* 11.01.2017 21:44: Fixed typos in the symlink-creation part
* 15.01.2017 22:06: Added alternative instructions on how to symlink the infinality-substitution snippet to `/etc/fonts/conf.d`, since it is now part of the `fonts-meta-extended-lt` package.
* 23.01.2017 16:41: Added mirror links to missing optional fonts in step 2 in the "Creating an Infinality-like fontconfig Configuration"-section, since bohoomil's font repository seems to be offline now.

General
=======

If you installed infinality-bundle or the patched `freetype2-infinality(-ultimate)` package, you'll most likely recently have run into an error relating to the `harfbuzz` package (>= 1.4.1-1), specifically something like: `/usr/lib/libharfbuzz.so.0: undefined symbol: FT_Get_Var_Blend_Coordinates`.

This is because the packages provided by the [Infinality](https://wiki.archlinux.org/index.php/Infinality) repositories or even the [freetype2-infinality](https://aur.archlinux.org/packages/freetype2-infinality/) on AUR are and have been outdated for quite some time, since infinality-bundle's creator, [bohoomil](http://bohoomil.com/), has been missing/unresponsive for the past few months. freetype2 since has gotten new features and a changed ABI, one of which is a symbol named `FT_Get_Var_Blend_Coordinates` which the updated libharfbuzz tries to reference.

What this means for you is: you'll need a freetype2 version >= 2.7.1 where this change was initially [introduced](https://sourceforge.net/projects/freetype/files/freetype2/2.7.1/). Since the future of the infinality-bundle is uncertain this is a good time as any to bite the bullet and remove it completely from your system until more is known. The font rendering won't be exactly the same, but with a few tweaks it will at least be similar.


Removing the infinality-bundle
==============================

If you still have the infinality-bundle installed, specifically `fontconfig-infinality-ultimate`, run `sudo fc-presets set`, choose option 4) to reset and then 5) to quit `fc-presets` -- this will save you some work of removing dead symlinks in step 4) of the guide. If the package is already removed, that is no problem: removing broken symlinks isn't hard and there's only 4 of them.

A useful tool to remove all traces of the infinality-bundle will be [pkgbrowser](https://aur.archlinux.org/packages/pkgbrowser/). To prevent problems with using pkgbrowser down the line, start by doing the most important thing first: replacing the various packages from the infinality-bundle repository which caused the problem in the first place. Replace all packages listed below (as long as they are installed on your system) with their original versions (make sure to replace the packages all in one go to prevent potential dependency errors: `pacman -S <package1> <package2> ...`):

 * `freetype2-infinality-ultimate` -> `freetype2`
 * `lib32-freetype2-infinality-ultimate` -> `lib32-freetype2`
 * `fontconfig-infinality-ultimate` -> `fontconfig`
 * `lib32-fontconfig-infinality-ultimate` -> `lib32-fontconfig`
 * `cairo-infinality-ultimate` -> `cairo`
 * `lib32-cairo-infinality-ultimate` -> `lib32-cairo`
 * `jdk8-openjdk-infinality` -> `jdk8-openjdk`
 * `jre8-openjdk-infinality` -> `jre8-openjdk`
 * `jre8-openjdk-infinality` -> `jre8-openjdk-headless`

If for some reason you don't want to install pkgbrowser, you can also use `pacman -Sl <repository>` and `pacman -Sg <group>` (for example: `infinality-bundle`, `infinality-bundle-fonts` etc.) to list packages belonging to repositories and groups (and their installed-state marked by `[installed]`) respectively. `pacman -Qi <package>` can be used to get more detailed information on an installed package, such as the "Conflicts with" field.

If you explicitly installed fonts or font groups (for example `ibfonts-meta-extended`) from the `infinality-bundle-fonts` repository it is advised that you remove these, since some of them were specifically patched to work with the modifications the infinality-bundle made to the various packages mentioned above. The pkgbrowser tool is useful during this process: mark the `infinality-bundle-fonts` in the sidebar and sort using the `Status` column, remove those that were explicitly installed using: `pacman -Rns <package>`. If you simply installed `ibfonts-meta-extended` or a similar group of fonts, `pacman -Rns ibfonts-meta-extended` will have the expected effect.

After doing this, refresh the view in pkgbrowser using F5 and sort again by status. It is quite possible that still some packages are left which are marked as dependencies: these are packages that were most likely installed as dependencies by other packages, before you started using the infinality-bundle and subsequently replaced by Infinality-specific versions. For these, select them and search for the fields "Conflicts with" which should give you a good idea which package they originally replaced. The goal is to replace the Infinality-specific versions (ending in -ibx) with the original ones. For example:

 * `t1-urw-fonts-ib` conflicts with `gsfonts`: `pacman -S gsfonts` (answer yes to replace)
 * `ttf-dejavu-ib` conflicts with `ttf-dejavu`: `pacman -S ttf-dejavu` (answer yes to replace)

After taking care of all packages, no packages should be installed anymore when you check `infinality-bundle`, `infinality-bundle-multilib` and `infinality-bundle-fonts` in the sidebar. Your system should now be in a pre-infinality-bundle state.


Creating an Infinality-like fontconfig Configuration
====================================================

From this clean slate we can now create a similar fontconfig configuration to the infinality-bundle's without having to use the patched packages. Thanks to a few comments on previous versions of this article, it is now possible to easily get [great-looking results](http://i.imgur.com/P6ZFvJn.png) with the default freetype2 truetype interpreter.

1) Create the following symlinks using root to instruct freetype2 to use good-looking rendering defaults:
* `ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d`
* `ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d`
* `/etc/fonts/conf.avail/10-hinting-slight.conf` should already be linked to `/etc/fonts/conf.d`

Modify (or create) `/etc/fonts/local.conf` to contain [these contents](https://gist.github.com/cryzed/4f64bb79e80d619866ee0b18ba2d32fc). These are all [font substitutions originally made by Infinality's fontconfig configuration](http://bohoomil.com/doc/05-fonts/). A big thanks to [tylerswagar](https://github.com/tylerswagar) for creating the font substitution snippet! **Alternatively** run: `ln -s /etc/fonts/conf.avail/30-infinality-aliases.conf /etc/fonts/conf.d` _after_ installing `fonts-meta-extended-lt` in step 2; [DoctorJellyFace](https://github.com/DoctorJellyface), the maintainer of the `fonts-meta-extended-lt` package, decided to make the substitution snippet part of the package.

2) Now we need to actually make sure that we have all fonts on the system that were defined as substitutions earlier. Install the package [fonts-meta-extended-lt](https://aur.archlinux.org/packages/fonts-meta-extended-lt/) from the AUR, which will help us install and keep track of which fonts are required to do this. Fonts that are defined as optional dependencies for this PKGBUILD are those that are not yet available in the AUR. A big thanks to [DoctorJellyface](https://github.com/DoctorJellyface) for creating these AUR packages and maintaining them!

Install all optional dependencies of the `fonts-meta-base` and `fonts-meta-extended-lt` package. Do this by running `pacman -Qi fonts-meta-base fonts-meta-extended-lt` and noting the entries listed unter "Optional Deps". Then install them using `pacman -S <optdep1> <optdep2> ... --asdeps`. Currently missing optional font packages in the AUR are `t1-cursor-ib` and `ttf-gelasio-ib`. Mirrors to these packages (exactly as they were contained in the, now offline, `infinality-bundle-fonts` repository) are here:

* [t1-cursor-ib-1.0.4-2-any.pkg.tar.xz](https://mega.nz/#!Nks0iJAb!8nSMQMtmvHfnMXH1TJ7-QIMNQWOMdgpH803WVgg2qWI)
* [ttf-gelasio-ib-1.00-7-any.pkg.tar.xz](https://mega.nz/#!Bt0hRaSZ!zv0liCiAfLaw6_oewcwoG5TsXP9Ruu-HNUfrRVYfYDg)

You can install these using `pacman -U <filename> --asdeps`.

3) Modify `/etc/profile.d/jre.sh` if you had the patched openjdk/openjre packages installed to look like this:

```bash
# Do not change this unless you want to completely by-pass Arch Linux' way
# of handling Java versions and vendors. Instead, please use script `archlinux-java`
export PATH=${PATH}:/usr/lib/jvm/default/bin

# https://wiki.archlinux.org/index.php/java#Better_font_rendering
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
```

This will enable font anti-aliasing for Java applications according to the instructions found [here](https://wiki.archlinux.org/index.php/java#Better_font_rendering). Without these, fonts in Java applications will look completely aliased, unless a different provider for `java-environment` is used which might implement different font rendering.

4) After having done all this, restarting the X-server by logging in and out should apply all changes. Try to get used to them, because the future of the infinality-bundle is unknown for now. Keep an eye on [this](https://github.com/bohoomil/fontconfig-ultimate/issues/171) and [this](https://aur.archlinux.org/packages/freetype2-infinality/) and maybe this "guide" if you are curious about changes.

You should also consider checking `/etc/fonts/conf.d/` for broken symlinks pointing to `/etc/fonts/conf.avail.infinality/...`, that might have been left by the `fc-presets` script if you ran it, and removing them to be thorough. Finally, you can remove the various `infinality-bundle*` repositories from your `/etc/pacman.conf`.