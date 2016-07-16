<?xml version="1.0" encoding="UTF-8"?>
<ttFont sfntVersion="\x00\x01\x00\x00" ttLibVersion="2.5">

<!--

    Copyright (c) 2015, Werner Lemberg (wl@gnu.org),
    with Reserved Font Name `RasterInfo'.

    This Font Software is licensed under the SIL Open Font License,
    Version 1.1.  The license text is available with a FAQ at
    `http://scripts.sil.org/OFL'.

  -->

divert(`-1')

This file is a template for the GNU M4 macro processor.  Other M4
implementations probably won't work, since we need the extended GNU M4
capabilities of the `define' and `patsubst' built-in functions.  The used
version for development was 1.4.17.


Create the output file `RasterInfo.xml' with

  m4 < RasterInfo.m4 > RasterInfo.xml

which in turn can be converted to a TrueType font `RasterInfo.ttf' with the
TrueType assembler from the `fonttools' package.

  ttx RasterInfo.xml


We use { and } as M4 quote characters.

  changequote({, })


The `RasterInfo' TrueType font
==============================

This file defines a TrueType font called `RasterInfo.ttf'.  It contains two
sets of characters mapped to the character codes: 0x30-0x3b (i.e.,
digits 0-9, `:', and `;') and 0x23-0x25 (`#', `$', and `%').  Both a
Macintosh 1/0 and a Microsoft 4/3 cmap are present.

If a TrueType bytecode interpreter is active, the characters of the first
set return various information on the rasterizer, using output of the
`GETINFO' bytecode instruction.


    code  glyph name                     description
   --------------------------------------------------------------------
    0x30  PPEM                           the current PPEM value
    0x31  ScalerVersion                  the hinting engine version
    0x32  IsRotated                      1 if rotation is on
    0x33  IsStretched                    1 if stretching is on
    0x34  GrayscaleRendering             1 if grayscale rendering
    0x35  CleartypeEnabled               1 if ClearType enabled
    0x36  CleartypeCompatibleWidths      1 if ClearType's
                                           compatible width mode is on
    0x37  CleartypeVerticalLCD           1 if ClearType uses
                                           vertical LCD subpixels
    0x38  CleartypeBGRRendering          1 if ClearType uses BGR
                                           rendering instead of RGB
    0x39  CleartypeSubpixelPositioning   1 if ClearType uses
                                           subpixel positioning
    0x3a  CleartypeSymmetricalSmoothing  1 if ClearType's
                                           symmetrical smoothing is on
    0x3b  CleartypeGrayRendering         1 if Gray ClearType is on


The `PPEM' glyph displays 1 to 5 digits, with the advance width properly
adjusted.  The `ScalerVersion' glyph displays either one or two digits
(again with the advance width properly adjusted); see below for more.

All other characters display either `1' or `0', depending on whether the
described feature is active or not.

If any of the above characters is viewed without activated TrueType bytecode
hinting, one or more `E' glyphs (representing `Error') are shown.

The characters of the second set help find more information on the LCD
rendering and how it gets filtered.  They are also useful to set up a
correct value for display gamma correction.  Essentially, the characters
consist of slightly slanted zebra patterns; you have to view these glyphs at
a size of 96ppem (to be more precise, a multiple of 32ppem like 128ppem will
work also, but not as good as 96ppem).


    code  glyph name    stripe thickness  distance between stripes
   ----------------------------------------------------------------
    0x23  Black6White6  6 units           6 units
    0x24  Black5White7  5 units           7 units
    0x25  Black7White5  7 units           5 units


The scaler version
------------------

[This section is taken from FreeType's `ftttdrv.h' header file.]

Depending on the graphics framework, Microsoft uses different bytecode and
rendering engines.  As a consequence, the version numbers returned by a call
to the `GETINFO' bytecode instruction are more convoluted than desired.

Here are two tables that try to shed some light on the possible values for
the (MS) rasterizer engine, together with the additional features introduced
by it.


    GETINFO framework               version feature
   ---------------------------------------------------------------------
       [1                                   Macintosh System 6]
       [2                                   Macintosh System 7]
        3   GDI (Win 3.1),            v1.0  16-bit, first version
            TrueImage
       [4   KanjiTalk 6.1                   on the Mac]
       33   GDI (Win NT 3.1),         v1.5  32-bit
            HP Laserjet
       34   GDI (Win 95)              v1.6  font smoothing,
                                            new SCANTYPE instruction
       35   GDI (Win 98/2000)         v1.7  (UN)SCALED_COMPONENT_OFFSET
                                              bits in composite glyphs
       36   MGDI (Win CE 2)           v1.6+ classic ClearType
       37   GDI (XP and later),       v1.8  ClearType
            GDI+ old (before Vista)
       38   GDI+ old (Vista, Win 7),  v1.9  subpixel ClearType,
            WPF                             Y-direction ClearType,
                                            additional error checking
       39   DWrite (before Win 8)     v2.0  subpixel ClearType flags
                                              in GETINFO instruction,
                                            bug fixes
       40   GDI+ (after Win 7),       v2.1  Y-direction ClearType flag
            DWrite (Win 8)                    in GETINFO instruction,
                                            Gray ClearType


The `version' field gives a rough orientation only, since some applications
provided certain features much earlier (as an example, Microsoft Reader used
subpixel and Y-direction ClearType already in Windows 2000).  Similarly,
updates to a given framework might include improved hinting support.


     version   sampling          rendering        comment
              x        y       x           y
    --------------------------------------------------------------
      v1.0   normal  normal  B/W           B/W    bi-level
      v1.6   high    high    gray          gray   grayscale
      v1.8   high    normal  color-filter  B/W    (GDI) ClearType
      v1.9   high    high    color-filter  gray   Color ClearType
      v2.1   high    normal  gray          B/W    Gray ClearType
      v2.1   high    high    gray          gray   Gray ClearType


Color and Gray ClearType are the two available variants of `Y-direction
ClearType', meaning grayscale rasterization along the Y-direction; the name
used in the TrueType specification for this feature is `symmetric
smoothing'.  `Classic ClearType' is the original algorithm used before
introducing a modified version in Win~XP.  Another name for v1.6's grayscale
rendering is `font smoothing', and `Color ClearType' is sometimes also
called `DWrite ClearType'.  To differentiate between today's Color ClearType
and the earlier ClearType variant with B/W rendering along the vertical
axis, the latter is sometimes called `GDI ClearType'.

`Normal' and `high' sampling describe the (virtual) resolution to access the
rasterized outline after the hinting process.  `Normal' means 1 sample per
grid line (i.e., B/W).  In the current Microsoft implementation, `high'
means an extra virtual resolution of 16x16 (or 16x1) grid lines per pixel
for bytecode instructions like `MIRP'.  After hinting, these 16 grid lines
are mapped to 6x5 (or 6x1) grid lines for color filtering if Color ClearType
is activated.

Note that `Gray ClearType' is essentially the same as v1.6's grayscale
rendering.  However, the GETINFO instruction handles it differently: v1.6
returns bit~12 (hinting for grayscale), while v2.1 returns bits~13 (hinting
for ClearType), 18 (symmetrical smoothing), and~19 (Gray ClearType).  Also,
this mode respects bits 2 and~3 for the version~1 gasp table exclusively
(like Color ClearType), while v1.6 only respects the values of version~0
(bits 0 and~1).

FreeType doesn't provide all capabilities of the most recent ClearType
incarnation, thus its subpixel support is tagged as version~38.


The info glyph shape
--------------------

We construct a digit glyph as in the sketch below.


                     11111
           012345678901234

      30     +---------+     30    12
      29    +     6     +    29    11
      28    ++---------++    28    10
      27   + +         + +   27     9
      26   | |         | |   26
      25   | |         | |   25
      24   | |         | |   24                    2         3
      23   | |         | |   23                    +---------+
      22   |4|         |5|   22                 1 +           + 4
      21   | |         | |   21                    +---------+
      20   | |         | |   20                    0         5
      19   | |         | |   19
      18   | |         | |   18
      17   + +         + +   17     8                  4
      16    ++---------++    16     7                  +
      15    +     3     +    15     6               3 + + 5
      14    ++---------++    14     5                 | |
      13   + +         + +   13     4                 | |
      12   | |         | |   12                       | |
      11   | |         | |   11                       | |
      10   | |         | |   10                       | |
       9   | |         | |   9                        | |
       8   |1|         |2|   8                        | |
       7   | |         | |   7                        | |
       6   | |         | |   6                        | |
       5   | |         | |   5                      2 + + 0
       4   | |         | |   4                         +
       3   + +         + +   3      3                  1
       2    ++---------++    2      2
       1    +     0     +    1      1
       0     +---------+     0      0

           012345678901234
                     11111


  size: (lsb + 14 + rsb) x 30

  horizontal element points: 0: ( 1, 0)
                             1: ( 0, 1)
                             2: ( 1, 2)
                             3: (11, 2)
                             4: (12, 1)
                             5: (11, 0)

  vertical element points: 0: (2,  1)
                           1: (1,  0)
                           2: (0,  1)
                           3: (0, 11)
                           4: (1, 12)
                           5: (2, 11)

  element offsets: 0: horz ( 1, 0)
                   1: vert ( 0, 2)
                   2: vert (12, 2)
                   3: horz ( 1,14)
                   4: vert ( 0,16)
                   5: vert (12,16)
                   6: horz ( 1,28)

In the macros below, generic values are used for the glyph dimensions so
that they can be easily modified.

To display correct digit shapes depending on GETINFO information, this must
be controlled directly within the TrueType bytecode.  However, bytecode
can't create new outlines or points, it can only move points.  The solution
to this problem implemented here is to make the digit glyph consist of
solitary points (this is, one-point contours ignored by the rendering
engine) that indicate the vertical positions where the outlines will be
moved to.  Additionally, we create seven six-point outlines that have
correct x values but zero y values (and are thus ignored, too).  If, for
example, we have to render element 1, the bytecode aligns the points of the
first six-point contour vertically to the corresponding placeholder points.

Since we only shift points vertically, the following placeholder points are
sufficient (referring to the y coordinates; the x coordinate is not of
interest).

  0-3, 13-17, 27-30  (4 + 5 + 4 = 13 points)

In the above sketch of the complete glyph, placeholder point indices are
shown at the very right.


Subpixel positioning and advance width
--------------------------------------

The Windows bytecode engine doesn't allow modification of the advance width
if subpixel hinting is active.  For this reason, the previously mentioned
adjustment of the shown number of digits per glyph and its advance width is
enabled for non-subpixel hinting only.


The LCD test glyph shape
------------------------

This is the shape for `Black6White6', with 32 stripes.


                                       3 3 3 3 3
                   1 1 2 3 3           6 6 7 7 8
                   2 8 4 0 6           0 6 2 8 4

    384            ++  ++  ++   ....   ++  ++  ++
    372           //  //  //          //  //  //
    360          //  //  //          //  //  //
      .         ..  ..  ..          ..  ..  ..
      .         0   1   2          29  30  31
      .       ..  ..  ..          ..  ..  ..
     18      //  //  //          //  //  //
     12     //  //  //          //  //  //
      6    //  //  //          //  //  //
      0   ++  ++  ++   ....   ++  ++  ++

          0 6 1 1 2           3 3 3 3 3
              2 8 4           4 5 6 6 7
                              8 4 0 6 2


For `Black5White7' and `Black7White5' the interval series is

  0, 5, 12, 17, 24, ...

and

  0, 7, 12, 19, 24, ...   ,

respectively.  Value 384 gets then mapped to the number of units per EM.


Naming conventions
------------------

The following conventions for names are used.

  . M4 macros, constants, and variables: UPPERCASE_WITH_UNDERSCORES.

  . Bytecode functions: CamelCase.

  . Bytecode Storage Area locations: lowercase_with_underscores.

  . Bytecode Control Value Table (CVT) indices: Mixed_Case_With_Underscores.

  . Placeholder points: P_<point index> (example: `P_4').

  . Element points: P_<element index>_<nth point>.  For example, the fourth
    point in element 2 is `P_1_3' (since both indices and elements start
    with value 0).

  . For positioning subglyphs and adjusting the advance width we need
    alignment points: `P_0' (this is the first placeholder point), `P_00',
    `P_000', `P_0000', `P_00000', and `P_000000'.

Note that point names refer to the `digit' glyph, not to the glyph indices
in the composite glyphs.


Global setup
------------

The font version.

  define({VERSION}, 1.02)

We use 2048 units per EM.

  define({UPEM}, 2048)

The thickness (which must be an even value because we need its half also)
and the length of an element.

  define({THICKNESS}, 2)
  define({LENGTH}, 12)

The left and right side bearings of the digit glyph.

  define({LSB}, THICKNESS)
  define({RSB}, THICKNESS)

The width, height, and advance width of the digit glyph are derived as
follows.

  define({WIDTH},
    eval(THICKNESS / 2 + LENGTH + THICKNESS / 2))
  define({HEIGHT},
    eval(THICKNESS + LENGTH + THICKNESS + LENGTH + THICKNESS))
  define({ADV_WIDTH},
    eval(LSB + WIDTH + RSB))

For bytecode hinting we also need the horizontal and vertical width of the
two digit `holes' (as shown in digit `8').

  define({H_COUNTER},
    eval(WIDTH - THICKNESS))
  define({V_COUNTER},
    eval(LENGTH))

We scale everything to font units using a heuristic factor.

  define({SCALE}, 49)


Auxiliaries
-----------

To control the emitted whitespace while having a nicely vertical flow both
in the definition and the use of the M4 macros, we set up some auxiliary
macros.

We start with a loop macro that applies an iterator macro `var' to `stmt',
where `var' is incrementally assigned a number from a given number range
[from;to].

The macro trick using two macros for this definition is described in the GNU
M4 info manual in section `Building macros with macros'.

  # FORLOOP(var, from, to, stmt)
  define({FORLOOP},
    {ifelse(eval({($2) <= ($3)}),
            1,
            {pushdef({$1})_$0({$1},
                              eval({$2}),
                              eval({$3}),
                              {$4})popdef({$1})})})
  define({_FORLOOP},
    {define({$1},
       {$2})$4{}ifelse({$2},
                       {$3},
                       {},
                       {$0({$1},
                           incr({$2}),
                           {$3},
                           {$4})})})

This macro emits a newline.

  define({NL}, {
})

The next one returns its arguments concatenated, doing recursion.  We use
this to avoid unwanted addition of spaces to the output while being able to
use formatted input (in particular indentation).

  define({CONCAT},
    {ifelse({$#}, 0, {},
            {$#}, 1, {$1{}},
            {$1{}$0(shift($@))})})

Sometimes, we want to mention an already defined M4 macro in the explanatory
text.  To avoid side effects it would be best to suppress expansion by
quoting the macro name in such cases.  However, we no longer use ` and ' as
the M4 quotes but { and }, which look ugly if used for quoting in plain
text.  We thus go a different route by introducing `sdefine', a variant of
the `define' built-in, which checks the number of arguments, doing nothing
if there aren't any.  In other words, writing `FOO' expands to the string
`FOO' for a safely defined, argumentless macro `FOO', and we have to
explicitly append `()' to the macro name to make M4 expand it.

As an exception to our naming convention, this macro is all lowercase to
make it resemble the `define' built-in.

  define({sdefine},
    {_$0({$1},
         {$2},
         {$}{#},
         {$}{0})})
  define({_sdefine},
    {define({$1},
       {ifelse({$3},
               0,
               {{$4}},
               {$2})})})


Elements
--------

We define two macros to set up the point positions of a horizontal and
vertical element prototype, shown on the right side in the sketch above.
Both macros take a horizontal and a vertical offset as parameters.  Macros
`S', `ELEM_START', and `ELEM_END' are defined in various ways below to help
compute auxiliary variables, and to emit the necessary XML data.

  sdefine({H_ELEM},
    {CONCAT({ELEM_START()},
            {S(eval(THICKNESS / 2 + $1),
               eval($2))},
            {S(eval($1),
               eval(THICKNESS / 2 + $2))},
            {S(eval(THICKNESS / 2 + $1),
               eval(THICKNESS + $2))},
            {S(eval(LENGTH - THICKNESS / 2 + $1),
               eval(THICKNESS + $2))},
            {S(eval(LENGTH + $1),
               eval(THICKNESS / 2 + $2))},
            {S(eval(LENGTH - THICKNESS / 2 + $1),
               eval($2))},
            {ELEM_END()})})

  sdefine({V_ELEM},
    {CONCAT({ELEM_START()},
            {S(eval(THICKNESS + $1),
               eval(THICKNESS / 2 + $2))},
            {S(eval(THICKNESS / 2 + $1),
               eval($2))},
            {S(eval($1),
               eval(THICKNESS / 2 + $2))},
            {S(eval($1),
               eval(LENGTH - THICKNESS / 2 + $2))},
            {S(eval(THICKNESS / 2 + $1),
               eval(LENGTH + $2))},
            {S(eval(THICKNESS + $1),
               eval(LENGTH - THICKNESS / 2 + $2))},
            {ELEM_END()})})

For simplicity, we assume that both the horizontal and vertical elements
have the same number of points.  We store this value in `ELEM_SIZE', which
gets computed incrementally with the following four macro definitions and
one macro call.

  define({ELEM_START})
  define({ELEM_END})

  define({ELEM_SIZE}, 0)
  sdefine({S},
    {define({ELEM_SIZE},
       incr(ELEM_SIZE))})

  H_ELEM(0, 0)

Our digit glyph consists of `NUM_ELEM' elements; its value gets
incrementally computed below.

  define({NUM_ELEM}, 0)

Call this macro to add an element; the element name is set to `ELEM_<i>',
with <i> an integer starting with zero.

  sdefine({ELEMENT},
    {CONCAT({sdefine(format({{ELEM_%d}},
                            NUM_ELEM),
               {$1})},
            {define({NUM_ELEM},
               incr(NUM_ELEM))})})

And here are the elements.

  ELEMENT({H_ELEM(eval(LSB + THICKNESS / 2),
                  eval(0))})
  ELEMENT({V_ELEM(eval(LSB),
                  eval(THICKNESS))})
  ELEMENT({V_ELEM(eval(LSB + LENGTH),
                  eval(THICKNESS))})
  ELEMENT({H_ELEM(eval(LSB + THICKNESS / 2),
                  eval(LENGTH + THICKNESS))})
  ELEMENT({V_ELEM(eval(LSB),
                  eval(LENGTH + 2 * THICKNESS))})
  ELEMENT({V_ELEM(eval(LSB + LENGTH),
                  eval(LENGTH + 2 * THICKNESS))})
  ELEMENT({H_ELEM(eval(LSB + THICKNESS / 2),
                  eval(2 * LENGTH + 2 * THICKNESS))})


The DIGIT macro
---------------

A digit consists of all elements.  The macro below calls elements 0, 1, 2,
..., NUM_ELEM-1 sequentially.

  sdefine({DIGIT},
    {FORLOOP({i_},
             0,
             eval(NUM_ELEM - 1),
             {indir(ELEM_{}i_, {})})})


The formatted output
--------------------

To control what our `DIGIT' macro emits, we have to define and redefine
lower-level macros.


Placeholder points
..................

First, we set up the placeholder points.  As discussed above, we need one
placeholder point per vertical position.  To get them, we iterate over all
points and fill a (simulated) point array, using the vertical coordinate as
an index.  Since we use the horizontal position of `P_0' as an alignment
point also, we set the x coordinate to zero.

Here are the two macros to set and access elements of the point array.
Using `defn' in `POINT', its argument is not further expanded at reading
time.

  sdefine({POINT},
    {defn(format({{point[%d]}},
                 {$1}))})
  sdefine({POINT_SET},
    {define(format({{point[%d]}},
                   {$1}),
            {$2})})

  define({ELEM_START})
  define({ELEM_END})
  sdefine({S},
    {POINT_SET($2,
               CONCAT({      <contour>NL},
                      {format({        <pt x="%d" y="%d" on="1"/>NL},
                              0,
                              eval($2 * SCALE))},
                      {      </contour>NL}))})

Now call our digit macro to fill the array.

  DIGIT()

The next step is to compute the number of placeholder points.  We again use
a loop to iterate over the index range [0;HEIGHT] and check whether the
`POINT' macro returns a non-empty value.  We also use the loop to assign the
placeholder point names `P_<i>' for such cases (with `<i>' the corresponding
index).

  define({NUM_PLACEHOLDERS}, 0)
  FORLOOP({i_},
          0,
          HEIGHT,
          {ifelse(POINT(i_),
                  {},
                  {},
                  {CONCAT({define(format({{P_%d}},
                                         NUM_PLACEHOLDERS),
                             NUM_PLACEHOLDERS)},
                          {define({NUM_PLACEHOLDERS},
                             incr(NUM_PLACEHOLDERS))})})})

What follows is a macro that emits the placeholder points (collected with
the first call of the digit macro above), to be called later on.

  sdefine({PLACEHOLDERS},
    {FORLOOP({i_},
             0,
             HEIGHT,
             {ifelse(POINT(i_),
                     {},
                     {},
                     {POINT(i_)})})})


Alignment points
................

We use composite glyphs to construct a number from up to `NUM_SUBGLYPHS'
digit glyphs.

  define({NUM_SUBGLYPHS}, 5)

In the composite glyphs below, subglyphs should be horizontally stacked
after the points have been moved to their final positions using bytecode.

The OpenType standard provides two possibilities to position subglyphs,
either using coordinate offsets (to be set up before hinting) or point
indices.  Since we heavily adjust the advance width within the bytecode, we
have to use the latter.

The natural way would be to start with subglyphs 0 and 1, aligning a point
of the first subglyph with a point of the second subglyph, iteratively
repeating this to align a point from subglyph <i> with a point from subglyph
<i+1>.  After subglyph <i> gets added, the number of total points is
increased by the number of points of subglyph <i>.  Due to a bug in FreeType
versions earlier than 2.6.0, however, using point index values in the ranges
[128;255] and [32768;65535] fail.  For this very reason we define all
necessary alignment points directly in our digit glyph, aligning subglyphs
1, 2, ..., to subglyph 0 instead, thus circumventing the bug.

Here we set up `TEMP' to incrementally contain the strings `P_00', `P_000',
etc. (`P_0' is already defined).  These strings are then used as macro
names, expanding to point indices as expected.  We also incrementally set up
the `ALIGNMENTS' macro to emit the corresponding XML code.

  define({TEMP},
    {P_0})
  sdefine({ALIGNMENTS})
  FORLOOP({i_},
          1,
          eval(NUM_SUBGLYPHS),
          {CONCAT({define({TEMP},
                     defn({TEMP})0)},
                  {define(TEMP,
                     eval(NUM_PLACEHOLDERS + NUM_ELEM * ELEM_SIZE + i_ - 1))},
                  {sdefine({ALIGNMENTS},
                     CONCAT(defn(ALIGNMENTS),
                            {      <contour>NL},
                            {        <pt x="}eval(i_ * SCALE * ADV_WIDTH){" y="0" on="1"/>NL},
                            {      </contour>NL}))})})
  undefine({TEMP})


Element points
..............

Within the loop of the `DIGIT' macro, counter variable `i_' is the current
element index.  In `ELEM_START', we initialize (or reset) a counter `j_'
that gets incremented in macro `S'.  These values are used to define the
names of element points.

  sdefine({ELEM_START},
    {define({j_}, 0)})
  define({ELEM_END})
  define({S},
    {CONCAT({define(format({{P_%d_%d}},
                           i_,
                           j_),
               eval(NUM_PLACEHOLDERS + i_ * ELEM_SIZE + j_))},
            {define({j_},
               incr(j_))})})

  DIGIT()


Number of points
................

We are now able to compute the number of points of the digit glyph.

  define({NUM_POINTS},
    eval(NUM_PLACEHOLDERS + NUM_ELEM * ELEM_SIZE + NUM_SUBGLYPHS))


The outlines
............

By default, we display an `E' shape, indicating `error'; this gets displayed
if there is no bytecode interpreter.  To do that we have to redefine
elements 2 and 5, changing its vertical coordinate values to zero.
Similarly, we need different versions of the low-level output macros since
we now emit one six-point contour per element instead of six single points.

  sdefine({V_ELEM0},
    {CONCAT({ELEM_START()},
            {S(eval(THICKNESS     + $1), 0)},
            {S(eval(THICKNESS / 2 + $1), 0)},
            {S(eval(                $1), 0)},
            {S(eval(                $1), 0)},
            {S(eval(THICKNESS / 2 + $1), 0)},
            {S(eval(THICKNESS     + $1), 0)},
            {ELEM_END()})})
  sdefine({ELEM_2},
    {V_ELEM0(eval(LSB + LENGTH), 0)})
  sdefine({ELEM_5},
    {V_ELEM0(eval(LSB + LENGTH), 0)})

  define({S},
    {format({        <pt x="%d" y="%d" on="1"/>NL},
            eval($1 * SCALE),
            eval($2 * SCALE))})
  define({ELEM_START},
    {      <contour>NL})
  define({ELEM_END},
    {      </contour>NL})

We call the `DIGIT' macro later on.


Scaled variables
................

Finally, a set of convenience macros that give scaled values.  We also need
a heuristic constant `EXTRA_HEIGHT' to increase the ascent so that its value
harmonizes with other fonts.

  define({sTHICKNESS}, eval(SCALE * THICKNESS))
  define({sLENGTH}, eval(SCALE * LENGTH))
  define({sLSB}, eval(SCALE * LSB))
  define({sRSB}, eval(SCALE * RSB))
  define({sWIDTH}, eval(SCALE * WIDTH))
  define({sHEIGHT}, eval(SCALE * HEIGHT))
  define({sADV_WIDTH}, eval(SCALE * ADV_WIDTH))
  define({sH_COUNTER}, eval(SCALE * H_COUNTER))
  define({sV_COUNTER}, eval(SCALE * V_COUNTER))

  define({EXTRA_HEIGHT}, 4)
  define({sEXTRA_HEIGHT}, eval(SCALE * EXTRA_HEIGHT))


The ZEBRA macros
----------------

The zebra patterns consist of a series of stripes.  The macros below call
elements 0, 1, 2, ..., NUM_STRIPES.

  define({NUM_STRIPES}, 32)
  define({STRIPE_OFFSET}, 12)
  define({STRIPE_HEIGHT}, eval(NUM_STRIPES * STRIPE_OFFSET))

  define({BLACK_WIDTH_1}, 6)
  define({BLACK_WIDTH_2}, 5)
  define({BLACK_WIDTH_3}, 7)

  sdefine({ZEBRA_1},
    {FORLOOP({i_},
             0,
             eval(NUM_STRIPES - 1),
             {STRIPE(BLACK_WIDTH_1, i_)})})
  sdefine({ZEBRA_2},
    {FORLOOP({i_},
             0,
             eval(NUM_STRIPES - 1),
             {STRIPE(BLACK_WIDTH_2, i_)})})
  sdefine({ZEBRA_3},
    {FORLOOP({i_},
             0,
             eval(NUM_STRIPES - 1),
             {STRIPE(BLACK_WIDTH_3, i_)})})

We need a small auxiliary macro to convert the coordinate values used in the
sketch above to font units.

  define({FU}, {eval(($1 * UPEM + STRIPE_HEIGHT / 2) / STRIPE_HEIGHT)})

Now the definition of the `STRIPE' macro is straightforward.

  define({STRIPE},
    {CONCAT({      <contour>NL},
            {format({        <pt x="%d" y="%d" on="1"/>NL},
                    FU({eval(STRIPE_OFFSET * $2)}),
                    0)},
            {format({        <pt x="%d" y="%d" on="1"/>NL},
                    FU({eval(STRIPE_OFFSET * ($2 + 1))}),
                    FU(STRIPE_HEIGHT))},
            {format({        <pt x="%d" y="%d" on="1"/>NL},
                    FU({eval($1 + STRIPE_OFFSET * ($2 + 1))}),
                    FU(STRIPE_HEIGHT))},
            {format({        <pt x="%d" y="%d" on="1"/>NL},
                    FU({eval($1 + STRIPE_OFFSET * $2)}),
                    0)},
            {      </contour>NL})})


Bytecode support
----------------

TrueType's bytecode instructions resemble assembler code, not having any
labels, variable, or function names.  However, M4 comes to a rescue, so we
add some macros that improve this situation.


Functions
.........

First of all, we need a counter that gets incremented with each call to
`FUNCTION'.

  define({NUM_FUNCTIONS}, 0)

To allow forward references, we store bytecode function definitions as
macros in an array.  A bytecode function's name also becomes a macro,
holding a sequential number.  Later on, a call to the `FUNCTIONS' macro
emits the bytecode functions to the output.  Since function numbers never
change, and we also don't access `NUM_FUNCTIONS' within the bytecode, no
special care is needed if an already defined label gets prematurely expanded
in backward references; this allows us to omit the quoting of `FUNCTION's
second argument.

We expect below that calls to `FUNCTION' are indented by 2 spaces, and that
the closing parenthesis is on a line of its own and indented by 2 spaces,
too.

  sdefine({FUNCTION},
    {CONCAT(define(format({function[%d]},
                          NUM_FUNCTIONS),
              CONCAT({shift($*)})),
            define({$1},
              NUM_FUNCTIONS),
            {define({NUM_FUNCTIONS},
               incr(NUM_FUNCTIONS))})})

Contrary to the point array reading macro `POINT' we can't use `defn' this
time: We need another round of macro expansion to resolve forward
references.  While outputting the function data, we add four leading spaces
to get nice XML formatting.

  define({GET_FUNCTION},
    {patsubst(indir(format({{function[%d]}},
                           {$1})),
              {^},
              {    })})

Within `FUNCTION', we use the default M4 comment style for comments; a call
to the `patsubst' builtin removes them later on (this is necessary since M4
retains comments within macros).  The comments are mainly used to show the
stack after executing the bytecode function on the same line; such comments
start with prefix `s:', with the topmost stack element coming first.

  sdefine({FUNCTIONS},
    {patsubst(FORLOOP({i_},
                      0,
                      eval(NUM_FUNCTIONS - 1),
                      {CONCAT({      PUSH[ ]NL},
                              {        i_{}NL},
                              {      FDEF[ ]NL},
                              {    GET_FUNCTION(i_)},
                              {ENDF[ ]NL},
                              {NL})}),
              {\(^ *#.*
\| *#.*$\| *$\)},
              {})})


The bytecode storage area
.........................

Similar to functions, we need a counter of storage locations.

  define({NUM_STORAGE_LOCATIONS}, 0)

However, we only need a mapping between a storage location name and its
index, making the associated macro quite simple.

  sdefine({STORAGE},
    {CONCAT(define({$1},
              NUM_STORAGE_LOCATIONS),
            {define({NUM_STORAGE_LOCATIONS},
               incr(NUM_STORAGE_LOCATIONS))})})

And here the list of storage locations.

  STORAGE({glyph_offset})


The Control Value Table (CVT)
.............................

The `CVT' macro puts the given value into the `cvt' table; it also defines a
mapping between a CVT name and its index.  Because the values are located in
a separate SFNT table, no `maxp' entry is needed, so we define the macro
here and insert it below in the XML part (but before the bytecode tables so
that references are properly resolved to indices).

  define({NUM_CVT_ENTRIES}, 0)

  sdefine({CVT},
    {CONCAT({format({<cv index="%d" value="%d"/>},
                    NUM_CVT_ENTRIES,
                    $2)},
            {define({$1},
               NUM_CVT_ENTRIES)},
            {define({NUM_CVT_ENTRIES},
               incr(NUM_CVT_ENTRIES))})})


The `fpgm' bytecode
-------------------

Since the `maxp' table needs the number of bytecode functions, it makes
sense to have the code in the M4 section.

Here is a simplified sketch of the digit glyph.


           +- 6 -+
           |     |
           4     5
           |     |
           +- 3 -+
           |     |
           1     2
           |     |
           +- 0 -+


Digits are composed from elements, cf. the `DigitX' functions below.

  0   012 456
  1     2  5
  2   01 3 56
  3   0 23 56
  4     2345
  5   0 234 6
  6   01234 6
  7     2  56
  8   0123456
  9   0 23456

This table shows the element's outline mapping to placeholder indices (which
are in the range 0 to `NUM_PLACEHOLDERS - 1'), cf. the `ElementX' functions
below.

  0   0  1  2  2  1  0
  1   3  2  3  4  5  4
  2   3  2  3  4  5  4
  3   5  6  7  7  6  5
  4   8  7  8  9 10  9
  5   8  7  8  9 10  9
  6  10 11 12 12 11 10

  (For example, the first contour point of element 3 should be vertically
   aligned to placeholder point 5, the second point to point 6, etc.)


`DigitX' functions
..................

Don't change the order or location of the `DigitX' functions!  They must
have indices 0-9.  Function `HandleDigit' uses this property.

  FUNCTION(Digit0,
    PUSH[ ]
      Element0
      Element1
      Element2
      Element4
      Element5
      Element6
      6 HandleElement
    LOOPCALL[ ]
  )

  FUNCTION(Digit1,
    PUSH[ ]
      Element2
      Element5
      2 HandleElement
    LOOPCALL[ ]
  )

  FUNCTION(Digit2,
    PUSH[ ]
      Element0
      Element1
      Element3
      Element5
      Element6
      5 HandleElement
    LOOPCALL[ ]
  )

  FUNCTION(Digit3,
    PUSH[ ]
      Element0
      Element2
      Element3
      Element5
      Element6
      5 HandleElement
    LOOPCALL[ ]
  )

  FUNCTION(Digit4,
    PUSH[ ]
      Element2
      Element3
      Element4
      Element5
      4 HandleElement
    LOOPCALL[ ]
  )

  FUNCTION(Digit5,
    PUSH[ ]
      Element0
      Element2
      Element3
      Element4
      Element6
      5 HandleElement
    LOOPCALL[ ]
  )

  FUNCTION(Digit6,
    PUSH[ ]
      Element0
      Element1
      Element2
      Element3
      Element4
      Element6
      6 HandleElement
    LOOPCALL[ ]
  )

  FUNCTION(Digit7,
    PUSH[ ]
      Element2
      Element5
      Element6
      3 HandleElement
    LOOPCALL[ ]
  )

  FUNCTION(Digit8,
    PUSH[ ]
      Element0
      Element1
      Element2
      Element3
      Element4
      Element5
      Element6
      7 HandleElement
    LOOPCALL[ ]
  )

  FUNCTION(Digit9,
    PUSH[ ]
      Element0
      Element2
      Element3
      Element4
      Element5
      Element6
      6 HandleElement
    LOOPCALL[ ]
  )


`ElementX' functions
....................

We shift the points of vertical elements up and down by 1/4 pixel.  See the
documentation of the `ShiftPoints' function for a rationale.

  FUNCTION(Element0,
    PUSH[ ]
      0 1 2 2 1 0
      P_0_0
      glyph_offset
    RS[ ]
    ADD[ ] # contour start point + storage[glyph_offset]
    PUSH[ ]
      ELEM_SIZE AlignPoint
    LOOPCALL[ ]
  )

  FUNCTION(Element1,
    PUSH[ ]
      4 5 4 3 2 3
      P_1_0
      glyph_offset
    RS[ ]
    ADD[ ] # contour start point + storage[glyph_offset]
    PUSH[ ]
      ELEM_SIZE AlignPoint
    LOOPCALL[ ]

    PUSH[ ]
      P_1_0
      ShiftPoints
    CALL[ ]
  )

  FUNCTION(Element2,
    PUSH[ ]
      4 5 4 3 2 3
      P_2_0
      glyph_offset
    RS[ ]
    ADD[ ] # contour start point + storage[glyph_offset]
    PUSH[ ]
      ELEM_SIZE AlignPoint
    LOOPCALL[ ]

    PUSH[ ]
      P_2_0
      ShiftPoints
    CALL[ ]
  )

  FUNCTION(Element3,
    PUSH[ ]
      5 6 7 7 6 5
      P_3_0
      glyph_offset
    RS[ ]
    ADD[ ] # contour start point + storage[glyph_offset]
    PUSH[ ]
      ELEM_SIZE AlignPoint
    LOOPCALL[ ]
  )

  FUNCTION(Element4,
    PUSH[ ]
      9 10 9 8 7 8
      P_4_0
      glyph_offset
    RS[ ]
    ADD[ ] # contour start point + storage[glyph_offset]
    PUSH[ ]
      ELEM_SIZE AlignPoint
    LOOPCALL[ ]

    PUSH[ ]
      P_4_0
      ShiftPoints
    CALL[ ]
  )

  FUNCTION(Element5,
    PUSH[ ]
      9 10 9 8 7 8
      P_5_0
      glyph_offset
    RS[ ]
    ADD[ ] # contour start point + storage[glyph_offset]
    PUSH[ ]
      ELEM_SIZE AlignPoint
    LOOPCALL[ ]

    PUSH[ ]
      P_5_0
      ShiftPoints
    CALL[ ]
  )

  FUNCTION(Element6,
    PUSH[ ]
      10 11 12 12 11 10
      P_6_0
      glyph_offset
    RS[ ]
    ADD[ ] # contour start point + storage[glyph_offset]
    PUSH[ ]
      ELEM_SIZE AlignPoint
    LOOPCALL[ ]
  )

The next two functions are used for horizontal positioning.  Similarly as
above, we shift points of the horizontal elements to the left and right by
1/4 pixel.

  input stack: p

  FUNCTION(ElementH,
    DUP[ ]
    PUSH[ ]
      Left_Side_Bearing
      Elem_Thickness

      P_0
    SRP0[ ]

    RCVT[ ]
    SWAP[ ]
    RCVT[ ]
    ADD[ ]
    PUSH[ ]
      16
    SUB[ ] # Left_Side_Bearing + Elem_Thickness - 1/4px
    MSIRP[1] # align p and set rp0 also

    # s: p

    PUSH[ ]
      1
    ADD[ ]
    DUP[ ]
    PUSH[ ]
      Elem_Half_Thickness
    MIRP[11001] # rp0/nomindist/noround/black

    PUSH[ ]
      1
    ADD[ ]
    DUP[ ]
    PUSH[ ]
      Elem_Half_Thickness
    MIRP[10001] # rp0/nomindist/noround/black

    PUSH[ ]
      1
    ADD[ ]
    DUP[ ]
    PUSH[ ]
      32
      Horiz_Counter
    RCVT[ ]
    ADD[ ] # Horiz_Counter + 1/4px + 1/4px
    MSIRP[1] # align p and set rp0 also

    PUSH[ ]
      1
    ADD[ ]
    DUP[ ]
    PUSH[ ]
      Elem_Half_Thickness
    MIRP[10001] # rp0/nomindist/noround/black

    PUSH[ ]
      1
    ADD[ ]
    PUSH[ ]
      Elem_Half_Thickness
    MIRP[00001] # norp0/nomindist/noround/black
  )

  input stack: p
               offset for p

  FUNCTION(ElementV,
    DUP[ ]
    ROLL[ ]
    ROLL[ ] # s: p offset p
    PUSH[ ]
      P_0
    SRP0[ ]
    SWAP[ ]
    MSIRP[1] # align p and set rp0 also

    # s: p

    PUSH[ ]
      1
    ADD[ ]
    DUP[ ]
    PUSH[ ]
      Elem_Half_Thickness
    MIRP[10001] # rp0/nomindist/noround/black

    PUSH[ ]
      1
    ADD[ ]
    DUP[ ]
    PUSH[ ]
      Elem_Half_Thickness
    MIRP[10001] # rp0/nomindist/noround/black

    PUSH[ ]
      1
    ADD[ ]
    DUP[ ]
    ALIGNRP[ ]

    PUSH[ ]
      1
    ADD[ ]
    DUP[ ]
    PUSH[ ]
      Elem_Half_Thickness
    MIRP[10001] # rp0/nomindist/noround/black

    PUSH[ ]
      1
    ADD[ ]
    PUSH[ ]
      Elem_Half_Thickness
    MIRP[00001] # norp0/nomindist/noround/black
  )


ShiftPoints
...........

Shift points `p', `p+1', `p+2' down and points `p+3', `p+4', `p+5' up by 1/4
pixel (using `glyph_offset').  This operation ensures that the diagonal
parts of the outlines never lie on a pixel center, which might create
ambiguous situations otherwise in B/W rendering.  Additionally, it reduces
the distances between vertical and horizontal elements at smaller sizes,
improving the blackness.

We use super rounding for that, with a period of 0.5 pixels and a phase of
0.5*period.  For shifting to the right, we set the threshold to 0.5*period.
For shifting to the left, we use a threshold of 0.

  input stack: p

  FUNCTION(ShiftPoints,
    PUSH[ ]
      glyph_offset
      36 # 00:10:0100
    SROUND[ ]

    RS[ ]
    ADD[ ] # s: p+storage[glyph_offset]

    DUP[ ]
    MDAP[1]

    PUSH[ ]
      1
    ADD[ ]
    DUP[ ]
    MDAP[1]

    PUSH[ ]
      1
    ADD[ ]
    DUP[ ]
    MDAP[1]

    PUSH[ ]
      40 # 00:10:1000
    SROUND[ ]

    PUSH[ ]
      1
    ADD[ ]
    DUP[ ]
    MDAP[1]

    PUSH[ ]
      1
    ADD[ ]
    DUP[ ]
    MDAP[1]

    PUSH[ ]
      1
    ADD[ ]
    MDAP[1]

    ROFF[ ]
  )


HandleElement
.............

Call `ElementX' function.  After execution, clean up the stack.

  input stack: idx

  FUNCTION(HandleElement,
    CALL[ ]
    POP[ ]
  )


AlignPoint
..........

Move point `dest' so that it gets aligned with point `src'.

  input stack: dest
               src
  output stack: dest + 1

  FUNCTION(AlignPoint,
    SWAP[ ]
    SRP0[ ]

    DUP[ ] # s: dest dest
    ALIGNRP[ ]

    PUSH[ ]
      1
    ADD[ ] # s: dest+1
  )


HandleDigit
...........

Split off a digit from `n' at the right and display it.  Also decrease the
`glyph_offset' register.

  input stack: n
  output stack: n / 10

  FUNCTION(HandleDigit,
    DUP[ ]

    # Use an intermediate 26.6 value for division by 10 to
    # circumvent rounding problems with a buggy `DIV' instruction
    # in older versions of Monotype's `iType' bytecode interpreter.
    PUSH[ ]
      10
    DIV[ ] # t = n * 64 / 10
    FLOOR[ ]
    PUSH[ ]
      1
    MUL[ ] # floor(t/64) = floor(n/10)

    DUP[ ] # s: floor(n/10) floor(n/10) n
    PUSH[ ]
      640 # 10 * 64
    MUL[ ] # s: 10*floor(n/10) floor(n/10) n
    ROLL[ ]
    SWAP[ ] # s: 10*floor(n/10) n floor(n/10)
    SUB[ ] # s: n%10 floor(n/10)
    CALL[ ] # execute Digit(n%10)

    PUSH[ ]
      glyph_offset
      NUM_POINTS
      glyph_offset
    RS[ ]
    SWAP[ ]
    SUB[ ]
    WS[ ] # storage[glyph_offset] -= NUM_POINTS
  )


HandleNumber
............

Split `num' into decimal digits and display them.

  input stack: num
               num_subglyphs

  FUNCTION(HandleNumber,
    # initialization
    SVTCA[0] # work along the vertical axis

    PUSH[ ]
      0 # start value for ResetElements
      3 # for CINDEX

    # make default shape (`E') of digit glyphs disappear
    CINDEX[ ] # s: num_subglyphs 0 num num_subglyphs
    PUSH[ ]
      ResetElements
    LOOPCALL[ ]
    POP[ ] # clean up stack

    # check whether we use subpixel hinting
    PUSH[ ]
      Subpixel_Cleartype
    RCVT[ ]
    IF[ ]
      # yes, set up everything for using all available digits
      SWAP[ ] # s: num_subglyphs num
      DUP[ ] # s: num_subglyphs num_subglyphs num
      PUSH[ ]
        1
      SUB[ ]
      PUSH[ ]
        eval(NUM_POINTS * 64)
      MUL[ ] # s: offset num_subglyphs num

      PUSH[ ]
        glyph_offset
      SWAP[ ]
      WS[ ] # storage[glyph_offset] = offset
    ELSE[ ]
      # If subpixel hinting is disabled (or not available) we have to
      # determine the number of digits, since we split off digits at the
      # right side.
      DUP[ ]
      PUSH[ ]
        10
      LT[ ]
      IF[ ] # num < 10 ?
        PUSH[ ]
          1 # 1 digit
          eval(0 * NUM_POINTS) # offset
      ELSE[ ]
        DUP[ ]
        PUSH[ ]
          100
        LT[ ]
        IF[ ] # num < 100 ?
          PUSH[ ]
            2 # 2 digits
            eval(1 * NUM_POINTS) # offset
        ELSE[ ]
          DUP[ ]
          PUSH[ ]
            1000
          LT[ ]
          IF[ ] # num < 1000 ?
            PUSH[ ]
              3 # 3 digits
              eval(2 * NUM_POINTS) # offset
          ELSE[ ]
            DUP[ ]
            PUSH[ ]
              10000
            LT[ ]
            IF[ ] # num < 10000 ?
              PUSH[ ]
                4 # 4 digits
                eval(3 * NUM_POINTS) # offset
            ELSE[ ]
              PUSH[ ]
                5 # 5 digits
                eval(4 * NUM_POINTS) # offset
            EIF[ ]
          EIF[ ]
        EIF[ ]
      EIF[ ]

      PUSH[ ]
        glyph_offset
      SWAP[ ]
      WS[ ] # storage[glyph_offset] = offset

      # s: digits num num_subglyphs
      #
      # Depending on `num', we have a different number of digits, and we
      # want to accomodate the advance width accordingly by shifting phantom
      # point `n+1' (where `n' is the number points in the glyph).  The
      # `digit' bytecode positions the alignment points `P_00', `P_000',
      # etc., of the first subglyph to the correct values; it is thus
      # sufficient to select the right one.
      #
      ROLL[ ] # s: num_subglyphs digits num
      PUSH[ ]
        eval(NUM_POINTS * 64)
      MUL[ ]
      PUSH[ ]
        1
      ADD[ ] # s: P_right=NUM_POINTS*num_subglyphs+1 digits num

      PUSH[ ]
        eval(P_00 - 1)
        3
      CINDEX[ ]
      ADD[ ] # s: P_00+ P_right digits num

      # It would be natural now to use ALIGNRP or MSIRP for aligning the
      # phantom point with the alignment point.  However, both bytecode
      # operators might not work as expected in ClearType due to backwards
      # compatibility quirks, making the hinting engine completely ignore
      # those instructions along the horizontal direction.  In particular,
      # this affects FreeType before release 2.6.0, which doesn't support
      # native ClearType mode (i.e., setting INSTCTRL's flag 3).
      #
      # For this reason we fall back to the ISECT operator, which doesn't
      # have this limitation.  This instruction moves a point to the
      # intersection of two lines: For the first line we use the alignment
      # point itself, together with the topmost placeholder point.  The
      # other line we define by P_0 and again the alignment point.
      #
      DUP[ ]
      PUSH[ ]
        P_0
      SWAP[ ] # s: P_00+ P_0 P_00+ P_right digits num
      PUSH[ ]
        eval(NUM_PLACEHOLDERS - 1) # last, topmost placeholder point
      SVTCA[1] # we shift the phantom point horizontally
      ISECT[ ]
      SVTCA[0] # for the rest we work along the vertical axis
    EIF[ ]

    # s: digits num
    PUSH[ ]
      HandleDigit
    LOOPCALL[ ]

    POP[ ] # clean up stack
  )


ResetPoint
..........

Reset vertical coordinate of `dest' to zero.  Reference point 0 must already
be set.

  input stack: dest
  output stack: dest + 1

  FUNCTION(ResetPoint,
    DUP[ ]
    ALIGNRP[ ]

    PUSH[ ]
      1
    ADD[ ] # s: dest+1
  )


ResetElements
.............

Reset vertical coordinate of all elements to zero.

  input stack: current subglyph start point index
  output stack: next subglyph start point index

  FUNCTION(ResetElements,
    PUSH[ ]
      NUM_PLACEHOLDERS
      P_0
    SRP0[ ] # align to P_0
    ADD[ ] # skip placeholder points

    PUSH[ ]
      eval(NUM_ELEM * ELEM_SIZE)
      ResetPoint
    LOOPCALL[ ]

    PUSH[ ]
      eval(NUM_SUBGLYPHS)
    ADD[ ]
  )


RoundCvt
........

This function rounds a CVT value (without taking care of engine
compensation), assuring a minimum value of 1.

  input stack: CVT index

  FUNCTION(RoundCvt,
    DUP[ ]
    RCVT[ ]
    PUSH[ ]
      32
    ADD[ ]
    FLOOR[ ]
    PUSH[ ]
      64 # value 1 in 26.6 notation
    MAX[ ]
    WCVTP[ ]
  )


Here ends the M4 code.  The remaining part is the XML data needed for ttx,
interspersed with M4 constants and a few macro calls.  Note that from here
on we have to use the XML comment format.


divert(0)

<!--

     THIS IS A GENERATED FILE!  Source file was `RasterInfo.m4',
     processed with GNU M4.

  -->


  <!-- The values below are the minimum data needed by ttx. -->

  <GlyphOrder>
    <GlyphID name=".notdef"/>
    <GlyphID name=".null"/>
    <GlyphID name="nonmarkingreturn"/>
    <GlyphID name="space"/>
    <GlyphID name="digit"/>
    <GlyphID name="PPEM"/>
    <GlyphID name="ScalerVersion"/>
    <GlyphID name="IsRotated"/>
    <GlyphID name="IsStretched"/>
    <GlyphID name="GrayscaleRendering"/>
    <GlyphID name="CleartypeEnabled"/>
    <GlyphID name="CleartypeCompatibleWidths"/>
    <GlyphID name="CleartypeBGRRendering"/>
    <GlyphID name="CleartypeVerticalLCD"/>
    <GlyphID name="CleartypeSubpixelPositioning"/>
    <GlyphID name="CleartypeSymmetricalSmoothing"/>
    <GlyphID name="CleartypeGrayRendering"/>
    <GlyphID name="Black6White6"/>
    <GlyphID name="Black5White7"/>
    <GlyphID name="Black7White5"/>
  </GlyphOrder>

  <head>
    <tableVersion value="1.0"/>
    <fontRevision value="VERSION"/>
    <checkSumAdjustment value="0"/>
    <magicNumber value="0x5f0f3cf5"/>
    <flags value="00000000 00011111"/>
    <unitsPerEm value="2048"/>
    <created value="Sun May  3 00:00:00 2015"/>
    <macStyle value="00000000 00000000"/>
    <lowestRecPPEM value="6"/>
    <fontDirectionHint value="1"/>
    <glyphDataFormat value="0"/>
  </head>

  <hhea>
    <tableVersion value="1.0"/>
    <ascent value="eval(sHEIGHT + sEXTRA_HEIGHT)"/>
    <descent value="0"/>
    <lineGap value="eval(UPEM - sHEIGHT - sEXTRA_HEIGHT)"/> <!-- ascent + descent + lineGap = unitsPerEm -->
    <caretSlopeRise value="1"/>
    <caretSlopeRun value="0"/>
    <caretOffset value="0"/>
    <reserved0 value="0"/>
    <reserved1 value="0"/>
    <reserved2 value="0"/>
    <reserved3 value="0"/>
    <metricDataFormat value="0"/>
  </hhea>

  <maxp>
    <tableVersion value="0x10000"/>
    <maxZones value="1"/>
    <maxTwilightPoints value="0"/>
    <maxStorage value="NUM_STORAGE_LOCATIONS"/>
    <maxFunctionDefs value="NUM_FUNCTIONS"/>
    <maxInstructionDefs value="0"/>
    <maxStackElements value="100"/>
    <maxSizeOfInstructions value="200"/>
    <maxComponentElements value="NUM_SUBGLYPHS"/>
  </maxp>

  <OS_2>
    <version value="1"/>
    <xAvgCharWidth value="0"/>
    <usWeightClass value="400"/>
    <usWidthClass value="5"/>
    <fsType value="00000000 00000000"/>
    <ySubscriptXSize value="0"/>
    <ySubscriptYSize value="0"/>
    <ySubscriptXOffset value="0"/>
    <ySubscriptYOffset value="0"/>
    <ySuperscriptXSize value="0"/>
    <ySuperscriptYSize value="0"/>
    <ySuperscriptXOffset value="0"/>
    <ySuperscriptYOffset value="0"/>
    <yStrikeoutSize value="0"/>
    <yStrikeoutPosition value="0"/>
    <sFamilyClass value="3072"/> <!-- 0x0C00 -->
    <panose>
      <bFamilyType value="0"/>
      <bSerifStyle value="0"/>
      <bWeight value="0"/>
      <bProportion value="0"/>
      <bContrast value="0"/>
      <bStrokeVariation value="0"/>
      <bArmStyle value="0"/>
      <bLetterForm value="0"/>
      <bMidline value="0"/>
      <bXHeight value="0"/>
    </panose>
    <ulUnicodeRange1 value="00000000 00000000 00000000 00000000"/>
    <ulUnicodeRange2 value="00000000 00000000 00000000 00000000"/>
    <ulUnicodeRange3 value="00000000 00000000 00000000 00000000"/>
    <ulUnicodeRange4 value="00000000 00000000 00000000 00000000"/>
    <achVendID value="XXXX"/>
    <fsSelection value="00000000 01000000"/>
    <usFirstCharIndex value="8"/>
    <usLastCharIndex value="59"/> <!-- 0x3b -->
    <sTypoAscender value="eval(sHEIGHT + sEXTRA_HEIGHT)"/>
    <sTypoDescender value="0"/>
    <sTypoLineGap value="eval(UPEM - sHEIGHT - sEXTRA_HEIGHT)"/> <!-- ascender + descender + linegap = unitsPerEm -->
    <usWinAscent value="eval(sHEIGHT + sEXTRA_HEIGHT)"/>
    <usWinDescent value="0"/>
    <ulCodePageRange1 value="00000000 00000000 00000000 00000000"/>
    <ulCodePageRange2 value="00000000 00000000 00000000 00000000"/>
  </OS_2>

  <!-- lsb = 0 (since placeholder points have x = 0) -->
  <hmtx>
    <mtx name=".notdef" width="sADV_WIDTH" lsb="0"/>
    <mtx name=".null" width="0" lsb="0"/>
    <mtx name="Black5White7" width="UPEM" lsb="0"/>
    <mtx name="Black6White6" width="UPEM" lsb="0"/>
    <mtx name="Black7White5" width="UPEM" lsb="0"/>
    <mtx name="CleartypeBGRRendering" width="sADV_WIDTH" lsb="0"/>
    <mtx name="CleartypeCompatibleWidths" width="sADV_WIDTH" lsb="0"/>
    <mtx name="CleartypeEnabled" width="sADV_WIDTH" lsb="0"/>
    <mtx name="CleartypeGrayRendering" width="sADV_WIDTH" lsb="0"/>
    <mtx name="CleartypeSubpixelPositioning" width="sADV_WIDTH" lsb="0"/>
    <mtx name="CleartypeSymmetricalSmoothing" width="sADV_WIDTH" lsb="0"/>
    <mtx name="CleartypeVerticalLCD" width="sADV_WIDTH" lsb="0"/>
    <mtx name="GrayscaleRendering" width="sADV_WIDTH" lsb="0"/>
    <mtx name="IsRotated" width="sADV_WIDTH" lsb="0"/>
    <mtx name="IsStretched" width="sADV_WIDTH" lsb="0"/>
    <mtx name="PPEM" width="eval(5 * sADV_WIDTH)" lsb="0"/>
    <mtx name="ScalerVersion" width="eval(2 * sADV_WIDTH)" lsb="0"/>
    <mtx name="digit" width="sADV_WIDTH" lsb="0"/>
    <mtx name="nonmarkingreturn" width="sADV_WIDTH" lsb="0"/>
    <mtx name="space" width="sADV_WIDTH" lsb="0"/>
  </hmtx>

  <cmap>
    <tableVersion version="0"/>
    <cmap_format_6 platformID="1" platEncID="0" language="0">
      <map code="0x8" name=".null"/>
      <map code="0x9" name="nonmarkingreturn"/>
      <map code="0xa" name=".notdef"/>
      <map code="0xb" name=".notdef"/>
      <map code="0xc" name=".notdef"/>
      <map code="0xd" name="nonmarkingreturn"/>
      <map code="0xe" name=".notdef"/>
      <map code="0xf" name=".notdef"/>
      <map code="0x10" name=".notdef"/>
      <map code="0x11" name=".notdef"/>
      <map code="0x12" name=".notdef"/>
      <map code="0x13" name=".notdef"/>
      <map code="0x14" name=".notdef"/>
      <map code="0x15" name=".notdef"/>
      <map code="0x16" name=".notdef"/>
      <map code="0x17" name=".notdef"/>
      <map code="0x18" name=".notdef"/>
      <map code="0x19" name=".notdef"/>
      <map code="0x1a" name=".notdef"/>
      <map code="0x1b" name=".notdef"/>
      <map code="0x1c" name=".notdef"/>
      <map code="0x1d" name=".null"/>
      <map code="0x1e" name=".notdef"/>
      <map code="0x1f" name=".notdef"/>
      <map code="0x20" name="space"/>
      <map code="0x21" name=".notdef"/>
      <map code="0x22" name=".notdef"/>
      <map code="0x23" name="Black6White6"/>
      <map code="0x24" name="Black5White7"/>
      <map code="0x25" name="Black7White5"/>
      <map code="0x26" name=".notdef"/>
      <map code="0x27" name=".notdef"/>
      <map code="0x28" name=".notdef"/>
      <map code="0x29" name=".notdef"/>
      <map code="0x2a" name=".notdef"/>
      <map code="0x2b" name=".notdef"/>
      <map code="0x2c" name=".notdef"/>
      <map code="0x2d" name=".notdef"/>
      <map code="0x2e" name=".notdef"/>
      <map code="0x2f" name=".notdef"/>
      <map code="0x30" name="PPEM"/>
      <map code="0x31" name="ScalerVersion"/>
      <map code="0x32" name="IsRotated"/>
      <map code="0x33" name="IsStretched"/>
      <map code="0x34" name="GrayscaleRendering"/>
      <map code="0x35" name="CleartypeEnabled"/>
      <map code="0x36" name="CleartypeCompatibleWidths"/>
      <map code="0x37" name="CleartypeVerticalLCD"/>
      <map code="0x38" name="CleartypeBGRRendering"/>
      <map code="0x39" name="CleartypeSubpixelPositioning"/>
      <map code="0x3a" name="CleartypeSymmetricalSmoothing"/>
      <map code="0x3b" name="CleartypeGrayRendering"/>
      <map code="0x3c" name=".notdef"/>
      <map code="0x3d" name=".notdef"/>
      <map code="0x3e" name=".notdef"/>
      <map code="0x3f" name=".notdef"/>
      <map code="0x40" name=".notdef"/>
      <map code="0x41" name=".notdef"/>
      <map code="0x42" name=".notdef"/>
      <map code="0x43" name=".notdef"/>
      <map code="0x44" name=".notdef"/>
      <map code="0x45" name=".notdef"/>
      <map code="0x46" name=".notdef"/>
      <map code="0x47" name=".notdef"/>
      <map code="0x48" name=".notdef"/>
      <map code="0x49" name=".notdef"/>
      <map code="0x4a" name=".notdef"/>
      <map code="0x4b" name=".notdef"/>
      <map code="0x4c" name=".notdef"/>
      <map code="0x4d" name=".notdef"/>
      <map code="0x4e" name=".notdef"/>
      <map code="0x4f" name=".notdef"/>
      <map code="0x50" name=".notdef"/>
      <map code="0x51" name=".notdef"/>
      <map code="0x52" name=".notdef"/>
      <map code="0x53" name=".notdef"/>
      <map code="0x54" name=".notdef"/>
      <map code="0x55" name=".notdef"/>
      <map code="0x56" name=".notdef"/>
      <map code="0x57" name=".notdef"/>
      <map code="0x58" name=".notdef"/>
      <map code="0x59" name=".notdef"/>
      <map code="0x5a" name=".notdef"/>
      <map code="0x5b" name=".notdef"/>
      <map code="0x5c" name=".notdef"/>
      <map code="0x5d" name=".notdef"/>
      <map code="0x5e" name=".notdef"/>
      <map code="0x5f" name=".notdef"/>
      <map code="0x60" name=".notdef"/>
      <map code="0x61" name=".notdef"/>
      <map code="0x62" name=".notdef"/>
      <map code="0x63" name=".notdef"/>
      <map code="0x64" name=".notdef"/>
      <map code="0x65" name=".notdef"/>
      <map code="0x66" name=".notdef"/>
      <map code="0x67" name=".notdef"/>
      <map code="0x68" name=".notdef"/>
      <map code="0x69" name=".notdef"/>
      <map code="0x6a" name=".notdef"/>
      <map code="0x6b" name=".notdef"/>
      <map code="0x6c" name=".notdef"/>
      <map code="0x6d" name=".notdef"/>
      <map code="0x6e" name=".notdef"/>
      <map code="0x6f" name=".notdef"/>
      <map code="0x70" name=".notdef"/>
      <map code="0x71" name=".notdef"/>
      <map code="0x72" name=".notdef"/>
      <map code="0x73" name=".notdef"/>
      <map code="0x74" name=".notdef"/>
      <map code="0x75" name=".notdef"/>
      <map code="0x76" name=".notdef"/>
      <map code="0x77" name=".notdef"/>
      <map code="0x78" name=".notdef"/>
      <map code="0x79" name=".notdef"/>
      <map code="0x7a" name=".notdef"/>
      <map code="0x7b" name=".notdef"/>
      <map code="0x7c" name=".notdef"/>
      <map code="0x7d" name=".notdef"/>
      <map code="0x7e" name=".notdef"/>
      <map code="0x7f" name=".notdef"/>
      <map code="0x80" name=".notdef"/>
      <map code="0x81" name=".notdef"/>
      <map code="0x82" name=".notdef"/>
      <map code="0x83" name=".notdef"/>
      <map code="0x84" name=".notdef"/>
      <map code="0x85" name=".notdef"/>
      <map code="0x86" name=".notdef"/>
      <map code="0x87" name=".notdef"/>
      <map code="0x88" name=".notdef"/>
      <map code="0x89" name=".notdef"/>
      <map code="0x8a" name=".notdef"/>
      <map code="0x8b" name=".notdef"/>
      <map code="0x8c" name=".notdef"/>
      <map code="0x8d" name=".notdef"/>
      <map code="0x8e" name=".notdef"/>
      <map code="0x8f" name=".notdef"/>
      <map code="0x90" name=".notdef"/>
      <map code="0x91" name=".notdef"/>
      <map code="0x92" name=".notdef"/>
      <map code="0x93" name=".notdef"/>
      <map code="0x94" name=".notdef"/>
      <map code="0x95" name=".notdef"/>
      <map code="0x96" name=".notdef"/>
      <map code="0x97" name=".notdef"/>
      <map code="0x98" name=".notdef"/>
      <map code="0x99" name=".notdef"/>
      <map code="0x9a" name=".notdef"/>
      <map code="0x9b" name=".notdef"/>
      <map code="0x9c" name=".notdef"/>
      <map code="0x9d" name=".notdef"/>
      <map code="0x9e" name=".notdef"/>
      <map code="0x9f" name=".notdef"/>
      <map code="0xa0" name=".notdef"/>
      <map code="0xa1" name=".notdef"/>
      <map code="0xa2" name=".notdef"/>
      <map code="0xa3" name=".notdef"/>
      <map code="0xa4" name=".notdef"/>
      <map code="0xa5" name=".notdef"/>
      <map code="0xa6" name=".notdef"/>
      <map code="0xa7" name=".notdef"/>
      <map code="0xa8" name=".notdef"/>
      <map code="0xa9" name=".notdef"/>
      <map code="0xaa" name=".notdef"/>
      <map code="0xab" name=".notdef"/>
      <map code="0xac" name=".notdef"/>
      <map code="0xad" name=".notdef"/>
      <map code="0xae" name=".notdef"/>
      <map code="0xaf" name=".notdef"/>
      <map code="0xb0" name=".notdef"/>
      <map code="0xb1" name=".notdef"/>
      <map code="0xb2" name=".notdef"/>
      <map code="0xb3" name=".notdef"/>
      <map code="0xb4" name=".notdef"/>
      <map code="0xb5" name=".notdef"/>
      <map code="0xb6" name=".notdef"/>
      <map code="0xb7" name=".notdef"/>
      <map code="0xb8" name=".notdef"/>
      <map code="0xb9" name=".notdef"/>
      <map code="0xba" name=".notdef"/>
      <map code="0xbb" name=".notdef"/>
      <map code="0xbc" name=".notdef"/>
      <map code="0xbd" name=".notdef"/>
      <map code="0xbe" name=".notdef"/>
      <map code="0xbf" name=".notdef"/>
      <map code="0xc0" name=".notdef"/>
      <map code="0xc1" name=".notdef"/>
      <map code="0xc2" name=".notdef"/>
      <map code="0xc3" name=".notdef"/>
      <map code="0xc4" name=".notdef"/>
      <map code="0xc5" name=".notdef"/>
      <map code="0xc6" name=".notdef"/>
      <map code="0xc7" name=".notdef"/>
      <map code="0xc8" name=".notdef"/>
      <map code="0xc9" name=".notdef"/>
      <map code="0xca" name=".notdef"/>
      <map code="0xcb" name=".notdef"/>
      <map code="0xcc" name=".notdef"/>
      <map code="0xcd" name=".notdef"/>
      <map code="0xce" name=".notdef"/>
      <map code="0xcf" name=".notdef"/>
      <map code="0xd0" name=".notdef"/>
      <map code="0xd1" name=".notdef"/>
      <map code="0xd2" name=".notdef"/>
      <map code="0xd3" name=".notdef"/>
      <map code="0xd4" name=".notdef"/>
      <map code="0xd5" name=".notdef"/>
      <map code="0xd6" name=".notdef"/>
      <map code="0xd7" name=".notdef"/>
      <map code="0xd8" name=".notdef"/>
      <map code="0xd9" name=".notdef"/>
      <map code="0xda" name=".notdef"/>
      <map code="0xdb" name=".notdef"/>
      <map code="0xdc" name=".notdef"/>
      <map code="0xdd" name=".notdef"/>
      <map code="0xde" name=".notdef"/>
      <map code="0xdf" name=".notdef"/>
      <map code="0xe0" name=".notdef"/>
      <map code="0xe1" name=".notdef"/>
      <map code="0xe2" name=".notdef"/>
      <map code="0xe3" name=".notdef"/>
      <map code="0xe4" name=".notdef"/>
      <map code="0xe5" name=".notdef"/>
      <map code="0xe6" name=".notdef"/>
      <map code="0xe7" name=".notdef"/>
      <map code="0xe8" name=".notdef"/>
      <map code="0xe9" name=".notdef"/>
      <map code="0xea" name=".notdef"/>
      <map code="0xeb" name=".notdef"/>
      <map code="0xec" name=".notdef"/>
      <map code="0xed" name=".notdef"/>
      <map code="0xee" name=".notdef"/>
      <map code="0xef" name=".notdef"/>
      <map code="0xf0" name=".notdef"/>
      <map code="0xf1" name=".notdef"/>
      <map code="0xf2" name=".notdef"/>
      <map code="0xf3" name=".notdef"/>
      <map code="0xf4" name=".notdef"/>
      <map code="0xf5" name=".notdef"/>
      <map code="0xf6" name=".notdef"/>
      <map code="0xf7" name=".notdef"/>
      <map code="0xf8" name=".notdef"/>
      <map code="0xf9" name=".notdef"/>
      <map code="0xfa" name=".notdef"/>
      <map code="0xfb" name=".notdef"/>
      <map code="0xfc" name=".notdef"/>
      <map code="0xfd" name=".notdef"/>
      <map code="0xfe" name=".notdef"/>
      <map code="0xff" name=".notdef"/>
    </cmap_format_6>
    <cmap_format_4 platformID="3" platEncID="1" language="0">
      <map code="0x0008" name=".null"/>
      <map code="0x0009" name="nonmarkingreturn"/>
      <map code="0x000d" name="nonmarkingreturn"/>
      <map code="0x001d" name=".null"/>
      <map code="0x0020" name="space"/>
      <map code="0x0023" name="Black6White6"/>
      <map code="0x0023" name="Black5White7"/>
      <map code="0x0023" name="Black7White5"/>
      <map code="0x0030" name="PPEM"/>
      <map code="0x0031" name="ScalerVersion"/>
      <map code="0x0032" name="IsRotated"/>
      <map code="0x0033" name="IsStretched"/>
      <map code="0x0034" name="GrayscaleRendering"/>
      <map code="0x0035" name="CleartypeEnabled"/>
      <map code="0x0036" name="CleartypeCompatibleWidths"/>
      <map code="0x0037" name="CleartypeVerticalLCD"/>
      <map code="0x0038" name="CleartypeBGRRendering"/>
      <map code="0x0039" name="CleartypeSubpixelPositioning"/>
      <map code="0x003a" name="CleartypeSymmetricalSmoothing"/>
      <map code="0x003b" name="CleartypeGrayRendering"/>
    </cmap_format_4>
  </cmap>

  <cvt>
    CVT(Elem_Thickness, sTHICKNESS)
    CVT(Elem_Half_Thickness, eval(sTHICKNESS / 2))
    CVT(Left_Side_Bearing, sLSB)
    CVT(Right_Side_Bearing, sRSB)
    CVT(Advance_Width, sADV_WIDTH)
    CVT(Glyph_Height, sHEIGHT)
    CVT(Horiz_Counter, sH_COUNTER)
    CVT(Vert_Counter, sV_COUNTER)
    CVT(Subpixel_Cleartype, 0)
  </cvt>

  <prep>
    <assembly>
      <!-- We round the CVT values and apply a minimum distance right here
           instead of using instructions like `SMD', which would not give
           correct output in native ClearType mode due to subpixel
           positioning. -->
      PUSH[ ]
        Elem_Half_Thickness
        32
        Elem_Thickness

        Elem_Thickness
        Left_Side_Bearing
        Right_Side_Bearing
        Advance_Width
        Glyph_Height

        5 RoundCvt

        0
        2
      SCANTYPE[ ] <!-- No dropout handling!  Otherwise our zero-height
                       outlines could become visible -->
      SMD[ ] <!-- no minimum distance; we handle that manually -->
      ROFF[ ] <!-- no rounding; we handle that manually, too -->

      LOOPCALL[ ] <!-- round CVT registers -->

      <!-- recompute `Elem_Half_Thickness' -->
      RCVT[ ]
      MUL[ ] <!-- effectively divide by 2 -->
      WCVTP[ ]

      <!-- we derive the rounded `Horiz_Counter' value from other values
           to minimize differences to the linear width -->
      PUSH[ ]
        Horiz_Counter
        64 <!-- value 1 in 26.6 notation -->
        Advance_Width
      RCVT[ ]

      PUSH[ ]
        Left_Side_Bearing
      RCVT[ ]
      PUSH[ ]
        Right_Side_Bearing
      RCVT[ ]
      ADD[ ]

      PUSH[ ]
        Elem_Thickness
      RCVT[ ]
      DUP[ ]
      ADD[ ]

      ADD[ ]
      SUB[ ]
      MAX[ ]
      WCVTP[ ]

      <!-- we derive the rounded `Vert_Counter' value from other values
           to minimize differences to the linear glyph height -->
      PUSH[ ]
        Vert_Counter
        32
        128 <!-- value 2 in 26.6 notation -->
        Glyph_Height
      RCVT[ ]

      PUSH[ ]
        Elem_Thickness
      RCVT[ ]
      DUP[ ]
      DUP[ ]
      ADD[ ]
      ADD[ ]

      SUB[ ]
      MAX[ ]

      <!-- `Glyph_Height - 3*Elem_Thickness' must be even
           so that we get an integer as the result of the division by 2 -->
      DUP[ ]
      ODD[ ]
      IF[ ]
        PUSH[ ]
          64
        ADD[ ]
      EIF[ ]

      MUL[ ] <!-- effectively divide by 2 -->
      WCVTP[ ]

      PUSH[ ]
        37
        1
      GETINFO[ ] <!-- if we have at least version 37 ... -->
      LTEQ[ ]
      IF[ ]
        PUSH[ ]
          64
          1
        GETINFO[ ] <!-- ... and ClearType is enabled, ... -->
        GTEQ[ ]
        IF[ ]
          PUSH[ ]
            4
            3
          INSTCTRL[ ] <!-- ... activate native ClearType mode -->
        EIF[ ]
      EIF[ ]

      PUSH[ ]
        38
        1
      GETINFO[ ] <!-- if we have at least version 38 ... -->
      LTEQ[ ]
      IF[ ]
        PUSH[ ]
          1024
        GETINFO[ ] <!-- ... check whether subpixel positioning is active -->
        IF[ ]
          PUSH[ ]
            Subpixel_Cleartype
            1
          WCVTP[ ]
        EIF[ ]
      EIF[ ]
    </assembly>
  </prep>

  <fpgm>
    <assembly>
FUNCTIONS()dnl
    </assembly>
  </fpgm>

  <loca>
  </loca>

  <glyf>
    <!-- we use the middle line of the `digit' glyph -->
    <TTGlyph name=".notdef" xMin="0" yMin="0" xMax="0" yMax="0">
ELEM_3()dnl
      <instructions><assembly>
        </assembly></instructions>
    </TTGlyph>

    <TTGlyph name=".null"/><!-- contains no outline data -->

    <!-- the zebra glyphs -->
    <TTGlyph name="Black5White7" xMin="0" yMin="0" xMax="0" yMax="0">
ZEBRA_2()dnl
      <instructions><assembly>
        </assembly></instructions>
    </TTGlyph>

    <TTGlyph name="Black6White6" xMin="0" yMin="0" xMax="0" yMax="0">
ZEBRA_1()dnl
      <instructions><assembly>
        </assembly></instructions>
    </TTGlyph>

    <TTGlyph name="Black7White5" xMin="0" yMin="0" xMax="0" yMax="0">
ZEBRA_3()dnl
      <instructions><assembly>
        </assembly></instructions>
    </TTGlyph>

    <TTGlyph name="CleartypeBGRRendering" xMin="0" yMin="0" xMax="0" yMax="0">
      <component glyphName="digit" x="0" y="0" flags="0x0"/>
      <instructions>
        <assembly>
          PUSH[ ]
            1 <!-- 1 digit to display -->
            37 <!-- this test needs at least version 37 -->
            1
          GETINFO[ ]
          LTEQ[ ]
          IF[ ]
            PUSH[ ]
              512 <!-- selector bit 9 -->
            GETINFO[ ]
            IF[ ]
              PUSH[ ]
                1
            ELSE[ ]
              PUSH[ ]
                0
            EIF[ ]
          ELSE[ ]
            PUSH[ ]
              0
          EIF[ ]

          PUSH[ ]
            HandleNumber
          CALL[ ]
        </assembly>
      </instructions>
    </TTGlyph>

    <TTGlyph name="CleartypeCompatibleWidths" xMin="0" yMin="0" xMax="0" yMax="0">
      <component glyphName="digit" x="0" y="0" flags="0x0"/>
      <instructions>
        <assembly>
          PUSH[ ]
            1 <!-- 1 digit to display -->
            37 <!-- this test needs at least version 37 -->
            1
          GETINFO[ ]
          LTEQ[ ]
          IF[ ]
            PUSH[ ]
              128 <!-- selector bit 7 -->
            GETINFO[ ]
            IF[ ]
              PUSH[ ]
                1
            ELSE[ ]
              PUSH[ ]
                0
            EIF[ ]
          ELSE[ ]
            PUSH[ ]
              0
          EIF[ ]

          PUSH[ ]
            HandleNumber
          CALL[ ]
        </assembly>
      </instructions>
    </TTGlyph>

    <TTGlyph name="CleartypeEnabled" xMin="0" yMin="0" xMax="0" yMax="0">
      <component glyphName="digit" x="0" y="0" flags="0x0"/>
      <instructions>
        <assembly>
          PUSH[ ]
            1 <!-- 1 digit to display -->
            36 <!-- this test needs at least version 36 -->
            1
          GETINFO[ ]
          LTEQ[ ]
          IF[ ]
            PUSH[ ]
              64 <!-- selector bit 6 -->
            GETINFO[ ]
            IF[ ]
              PUSH[ ]
                1
            ELSE[ ]
              PUSH[ ]
                0
            EIF[ ]
          ELSE[ ]
            PUSH[ ]
              0
          EIF[ ]

          PUSH[ ]
            HandleNumber
          CALL[ ]
        </assembly>
      </instructions>
    </TTGlyph>

    <TTGlyph name="CleartypeGrayRendering" xMin="0" yMin="0" xMax="0" yMax="0">
      <component glyphName="digit" x="0" y="0" flags="0x0"/>
      <instructions>
        <assembly>
          PUSH[ ]
            1 <!-- 1 digit to display -->
            40 <!-- this test needs at least version 40 -->
            1
          GETINFO[ ]
          LTEQ[ ]
          IF[ ]
            PUSH[ ]
              4096 <!-- selector bit 12 -->
            GETINFO[ ]
            IF[ ]
              PUSH[ ]
                1
            ELSE[ ]
              PUSH[ ]
                0
            EIF[ ]
          ELSE[ ]
            PUSH[ ]
              0
          EIF[ ]

          PUSH[ ]
            HandleNumber
          CALL[ ]
        </assembly>
      </instructions>
    </TTGlyph>

    <TTGlyph name="CleartypeSubpixelPositioning" xMin="0" yMin="0" xMax="0" yMax="0">
      <component glyphName="digit" x="0" y="0" flags="0x0"/>
      <instructions>
        <assembly>
          <!-- The MS rasterizer supports a query for this feature since
               version 39.  FreeType, however, identifies itself as version
               38 if subpixel hinting is active.  Thus we use value 38. -->
          PUSH[ ]
            1 <!-- 1 digit to display -->
            38
            1
          GETINFO[ ]
          LTEQ[ ]
          IF[ ]
            PUSH[ ]
              1024 <!-- selector bit 10 -->
            GETINFO[ ]
            IF[ ]
              PUSH[ ]
                1
            ELSE[ ]
              PUSH[ ]
                0
            EIF[ ]
          ELSE[ ]
            PUSH[ ]
              0
          EIF[ ]

          PUSH[ ]
            HandleNumber
          CALL[ ]
        </assembly>
      </instructions>
    </TTGlyph>

    <TTGlyph name="CleartypeSymmetricalSmoothing" xMin="0" yMin="0" xMax="0" yMax="0">
      <component glyphName="digit" x="0" y="0" flags="0x0"/>
      <instructions>
        <assembly>
          <!-- The MS rasterizer supports a query for this feature since
               version 39.  FreeType, however, identifies itself as version
               38 if subpixel hinting is active.  Thus we use value 38. -->
          PUSH[ ]
            1 <!-- 1 digit to display -->
            38
            1
          GETINFO[ ]
          LTEQ[ ]
          IF[ ]
            PUSH[ ]
              2048 <!-- selector bit 11 -->
            GETINFO[ ]
            IF[ ]
              PUSH[ ]
                1
            ELSE[ ]
              PUSH[ ]
                0
            EIF[ ]
          ELSE[ ]
            PUSH[ ]
              0
          EIF[ ]

          PUSH[ ]
            HandleNumber
          CALL[ ]
        </assembly>
      </instructions>
    </TTGlyph>

    <TTGlyph name="CleartypeVerticalLCD" xMin="0" yMin="0" xMax="0" yMax="0">
      <component glyphName="digit" x="0" y="0" flags="0x0"/>
      <instructions>
        <assembly>
          PUSH[ ]
            1 <!-- 1 digit to display -->
            37 <!-- this test needs at least version 37 -->
            1
          GETINFO[ ]
          LTEQ[ ]
          IF[ ]
            PUSH[ ]
              256 <!-- selector bit 8 -->
            GETINFO[ ]
            IF[ ]
              PUSH[ ]
                1
            ELSE[ ]
              PUSH[ ]
                0
            EIF[ ]
          ELSE[ ]
            PUSH[ ]
              0
          EIF[ ]

          PUSH[ ]
            HandleNumber
          CALL[ ]
        </assembly>
      </instructions>
    </TTGlyph>

    <TTGlyph name="GrayscaleRendering" xMin="0" yMin="0" xMax="0" yMax="0">
      <component glyphName="digit" x="0" y="0" flags="0x0"/>
      <instructions>
        <assembly>
          PUSH[ ]
            1 <!-- 1 digit to display -->
            32 <!-- selector bit 5 -->
          GETINFO[ ]
          IF[ ]
            PUSH[ ]
              1
          ELSE[ ]
            PUSH[ ]
              0
          EIF[ ]
          PUSH[ ]
            HandleNumber
          CALL[ ]
        </assembly>
      </instructions>
    </TTGlyph>

    <TTGlyph name="IsRotated" xMin="0" yMin="0" xMax="0" yMax="0">
      <component glyphName="digit" x="0" y="0" flags="0x0"/>
      <instructions>
        <assembly>
          PUSH[ ]
            1 <!-- 1 digit to display -->
            2 <!-- selector bit 1 -->
          GETINFO[ ]
          IF[ ]
            PUSH[ ]
              1
          ELSE[ ]
            PUSH[ ]
              0
          EIF[ ]
          PUSH[ ]
            HandleNumber
          CALL[ ]
        </assembly>
      </instructions>
    </TTGlyph>

    <TTGlyph name="IsStretched" xMin="0" yMin="0" xMax="0" yMax="0">
      <component glyphName="digit" x="0" y="0" flags="0x0"/>
      <instructions>
        <assembly>
          PUSH[ ]
            1 <!-- 1 digit to display -->
            4 <!-- selector bit 2 -->
          GETINFO[ ]
          IF[ ]
            PUSH[ ]
              1
          ELSE[ ]
            PUSH[ ]
              0
          EIF[ ]
          PUSH[ ]
            HandleNumber
          CALL[ ]
        </assembly>
      </instructions>
    </TTGlyph>

    <TTGlyph name="PPEM" xMin="0" yMin="0" xMax="0" yMax="0">
      <component glyphName="digit" x="0" y="0" flags="0x0"/>
      <component glyphName="digit" firstPt="P_00" secondPt="P_0" flags="0x0"/>
      <component glyphName="digit" firstPt="P_000" secondPt="P_0" flags="0x0"/>
      <component glyphName="digit" firstPt="P_0000" secondPt="P_0" flags="0x0"/>
      <component glyphName="digit" firstPt="P_00000" secondPt="P_0" flags="0x0"/>
      <instructions><assembly>
          PUSH[ ]
            5 <!-- up to 5 digits to display -->
          MPPEM[ ]
          PUSH[ ]
            HandleNumber
          CALL[ ]
        </assembly></instructions>
    </TTGlyph>

    <TTGlyph name="ScalerVersion" xMin="0" yMin="0" xMax="0" yMax="0">
      <component glyphName="digit" x="0" y="0" flags="0x0"/>
      <component glyphName="digit" firstPt="P_00" secondPt="P_0" flags="0x0"/>
      <instructions>
        <assembly>
          PUSH[ ]
            2 <!-- up to 2 digits to display -->
            1 <!-- selector bit 0 -->
          GETINFO[ ]
          PUSH[ ]
            HandleNumber
          CALL[ ]
        </assembly>
      </instructions>
    </TTGlyph>

    <!-- the main glyph -->
    <TTGlyph name="digit" xMin="0" yMin="0" xMax="0" yMax="0">
PLACEHOLDERS()dnl
DIGIT()dnl
ALIGNMENTS()dnl
      <instructions>
        <assembly>
          SVTCA[1] <!-- work along the horizontal axis -->

          <!-- position all element points -->
          PUSH[ ]
            Left_Side_Bearing
            Elem_Thickness

            P_0_0
            ElementH
            P_3_0
            ElementH
            P_6_0
            ElementH
          CALL[ ]
          CALL[ ]
          CALL[ ]

          RCVT[ ]
          SWAP[ ]
          RCVT[ ]
          ADD[ ] <!-- Left_Side_Bearing + Elem_Thickness -->

          DUP[ ]
          PUSH[ ]
            P_1_0
            ElementV
          CALL[ ]
          DUP[ ]
          PUSH[ ]
            P_4_0
            ElementV
          CALL[ ]

          PUSH[ ]
            Horiz_Counter
          RCVT[ ]
          ADD[ ]
          PUSH[ ]
            Elem_Thickness
          RCVT[ ]
          ADD[ ] <!-- Left_Side_Bearing + Horiz_Counter + 2*Elem_Thickness -->

          DUP[ ]
          PUSH[ ]
            P_2_0
            ElementV
          CALL[ ]
          DUP[ ]
          PUSH[ ]
            P_5_0
            ElementV
          CALL[ ]

          PUSH[ ]
            Right_Side_Bearing
          RCVT[ ]
          ADD[ ] <!-- new advance width -->

          DUP[ ]
          PUSH[ ]
            P_00
            P_0
          SRP0[ ]
          SWAP[ ]
          MSIRP[1] <!-- align P_00 and set rp0 -->

          DUP[ ]
          PUSH[ ]
            P_000
          SWAP[ ]
          MSIRP[1] <!-- align P_000 and set rp0 -->

          DUP[ ]
          PUSH[ ]
            P_0000
          SWAP[ ]
          MSIRP[1] <!-- align P_0000 and set rp0 -->

          DUP[ ]
          PUSH[ ]
            P_00000
          SWAP[ ]
          MSIRP[1] <!-- align P_00000 and set rp0 -->

          PUSH[ ]
            P_000000
          SWAP[ ]
          MSIRP[0] <!-- align P_000000 -->

          SVTCA[0] <!-- work along the vertical axis -->

          <!-- align placeholder points for edges -->
          PUSH[ ]
            P_12
            Elem_Thickness
            P_10
            Vert_Counter
            P_7
            Elem_Thickness
            P_5
            Vert_Counter
            P_2
            Elem_Thickness

            P_0
          SRP0[ ]

          MIRP[11001] <!-- rp0/mindist/noround/black -->
          MIRP[11010] <!-- rp0/mindist/noround/white -->
          MIRP[11001] <!-- rp0/mindist/noround/black -->
          MIRP[11010] <!-- rp0/mindist/noround/white -->
          MIRP[11001] <!-- rp0/mindist/noround/black -->

          <!-- position the remaining placeholder points -->
          PUSH[ ]
            P_11
            Elem_Half_Thickness
            P_10

            P_9
            Elem_Half_Thickness
            P_10

            P_8
            Elem_Half_Thickness
            P_7

            P_6
            Elem_Half_Thickness
            P_5

            P_4
            Elem_Half_Thickness
            P_5

            P_3
            Elem_Half_Thickness
            P_2

            P_1
            Elem_Half_Thickness
            P_0

          SRP0[ ]
          MIRP[01001] <!-- norp0/mindist/noround/black -->
          SRP0[ ]
          MIRP[01010] <!-- norp0/mindist/noround/white -->
          SRP0[ ]
          MIRP[01010] <!-- norp0/mindist/noround/white -->
          SRP0[ ]
          MIRP[01001] <!-- norp0/mindist/noround/black -->
          SRP0[ ]
          MIRP[01010] <!-- norp0/mindist/noround/white -->
          SRP0[ ]
          MIRP[01010] <!-- norp0/mindist/noround/white -->
          SRP0[ ]
          MIRP[01001] <!-- norp0/mindist/noround/black -->

          <!-- the code to shift some points vertically is in the `ElementX'
               functions -->
        </assembly>
      </instructions>
    </TTGlyph>

    <TTGlyph name="nonmarkingreturn"/><!-- contains no outline data -->

    <TTGlyph name="space"/><!-- contains no outline data -->

  </glyf>

  <name>
    <namerecord nameID="0" platformID="1" platEncID="0" langID="0x0" unicode="True">
      Copyright © 2015 Werner Lemberg
    </namerecord>
    <namerecord nameID="1" platformID="1" platEncID="0" langID="0x0" unicode="True">
      RasterInfo
    </namerecord>
    <namerecord nameID="2" platformID="1" platEncID="0" langID="0x0" unicode="True">
      Regular
    </namerecord>
    <namerecord nameID="3" platformID="1" platEncID="0" langID="0x0" unicode="True">
      RasterInfo: Version VERSION
    </namerecord>
    <namerecord nameID="4" platformID="1" platEncID="0" langID="0x0" unicode="True">
      RasterInfo
    </namerecord>
    <namerecord nameID="5" platformID="1" platEncID="0" langID="0x0" unicode="True">
      Version VERSION
    </namerecord>
    <namerecord nameID="6" platformID="1" platEncID="0" langID="0x0" unicode="True">
      RasterInfo
    </namerecord>
    <namerecord nameID="13" platformID="1" platEncID="0" langID="0x0" unicode="True">
      Copyright (c) 2015, Werner Lemberg (wl@gnu.org),
with Reserved Font Name "RasterInfo".

This Font Software is licensed under the SIL Open Font License, Version 1.1.
The license text is available with a FAQ at "http://scripts.sil.org/OFL".
    </namerecord>
    <namerecord nameID="14" platformID="1" platEncID="0" langID="0x0" unicode="True">
      http://scripts.sil.org/OFL
    </namerecord>

    <namerecord nameID="0" platformID="3" platEncID="1" langID="0x409">
      Copyright © 2015 Werner Lemberg
    </namerecord>
    <namerecord nameID="1" platformID="3" platEncID="1" langID="0x409">
      RasterInfo
    </namerecord>
    <namerecord nameID="2" platformID="3" platEncID="1" langID="0x409">
      Regular
    </namerecord>
    <namerecord nameID="3" platformID="3" platEncID="1" langID="0x409">
      RasterInfo: Version VERSION
    </namerecord>
    <namerecord nameID="4" platformID="3" platEncID="1" langID="0x409">
      RasterInfo
    </namerecord>
    <namerecord nameID="5" platformID="3" platEncID="1" langID="0x409">
      Version VERSION
    </namerecord>
    <namerecord nameID="6" platformID="3" platEncID="1" langID="0x409">
      RasterInfo
    </namerecord>
    <namerecord nameID="13" platformID="3" platEncID="1" langID="0x409">
      Copyright (c) 2015, Werner Lemberg (wl@gnu.org),
with Reserved Font Name "RasterInfo".

This Font Software is licensed under the SIL Open Font License, Version 1.1.
The license text is available with a FAQ at "http://scripts.sil.org/OFL".
    </namerecord>
    <namerecord nameID="14" platformID="3" platEncID="1" langID="0x409">
      http://scripts.sil.org/OFL
    </namerecord>
  </name>

  <post>
    <formatType value="2.0"/>
    <italicAngle value="0.0"/>
    <underlinePosition value="-sTHICKNESS"/>
    <underlineThickness value="SCALE"/>
    <isFixedPitch value="0"/>
    <minMemType42 value="0"/>
    <maxMemType42 value="0"/>
    <minMemType1 value="0"/>
    <maxMemType1 value="0"/>
    <psNames>
    </psNames>
    <extraNames>
    </extraNames>
  </post>

  <gasp>
    <gaspRange rangeMaxPPEM="65535" rangeGaspBehavior="15"/>
  </gasp>

</ttFont>
