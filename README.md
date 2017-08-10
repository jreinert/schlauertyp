![logo](resources/logo.png)

This is a fork from [marcusmichaely/schlauertyp](https://github.com/marcusmichaely/schlauertyp)

Unlike the original ruby implementation this version is written in crystal and
as such compiles into a binary.  This version acts as a server backend capable
of rendering plain text, json, xml and html.

A lot of effort has been put into ensuring best possible performance which is
-- needless to say -- impeccable for a program this sophisticated.  Although
the strings used here stored in yaml files for easy editing they
are embedded in the binary during compile time for super-fast response times.

## Installation

`shards build [--release]`

## Usage

`bin/schlauer_typ [<host>:<port>]`

## Benchmarks

Because why would you just have to take my word for it?

        Content-Type  Req/s  Avg Res T  Variance        Ranking
    ===========================================================
          text/plain  18.69k (  53.5µs) (±38.12%)       fastest
    application/json  15.44k ( 64.78µs) (±35.98%)  1.21× slower
     application/xml  15.03k ( 66.53µs) (±19.10%)  1.24× slower
           text/html  12.71k (  78.7µs) (±11.31%)  1.47× slower

The benchmark was run on a Thinkpad X220 with an Intel Core i7 CPU with 4
hyperthreads and TurboBoost^tm disabled.

Still don't believe me? Run it yourself by starting `bin/schlauer_typ` and
then running `bin/benchmark`!

## Credits

All Credits to [marcusmichaely](https://github.com/marcusmichaely) for the
awesome Idea.
