# Examples

Install dependencies with

    $ elm-package install -y

Since there is [no way yet to install packages that are not on the official
package repo](https://github.com/elm-lang/elm-package/issues/87), you will have
to manually add the source of the library to the `elm-stuff` directory after
installing. To do this, 

 - Add the library directory to
   `elm-stuff/packages/sgillis/elm-highcharts/1.0.0`
 - Add the entry `"sgillis/elm-highcharts": 1.0.0` in
   `elm-stuff/exact-dependencies.json`
