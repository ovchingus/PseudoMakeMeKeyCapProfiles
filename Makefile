.POSIX:
.SUFFIXES: .stl .scad

.scad.stl:
	openscad --export-format binstl -o $@ $<

keys: MX_DES_Standard_R4.stl MX_DES_Standard_R3.stl MX_DES_Standard_R2.stl MX_DES_Standard_R3_deepdish.stl MX_DES_Standard_R5.stl MX_DES_Standard_R1.stl MX_DES_Thumb_3.stl MX_DES_Thumb_4.stl MX_DES_Thumb_5.stl
stems: MX_DES_Standard_R1_stem.stl MX_DES_Standard_R2_stem.stl MX_DES_Standard_R3_stem.stl MX_DES_Standard_R3_deepdish_stem.stl MX_DES_Standard_R4_stem.stl MX_DES_Standard_R5_stem.stl MX_DES_Thumb_3_stem.stl MX_DES_Thumb_4_stem.stl MX_DES_Thumb_5_stem.stl
keys-without-stems: MX_DES_Standard_R1_key_without_stem.stl MX_DES_Standard_R2_key_without_stem.stl MX_DES_Standard_R3_key_without_stem.stl MX_DES_Standard_R3_deepdish_key_without_stem.stl MX_DES_Standard_R4_key_without_stem.stl MX_DES_Standard_R5_key_without_stem.stl MX_DES_Thumb_3_key_without_stem.stl MX_DES_Thumb_4_key_without_stem.stl MX_DES_Thumb_5_key_without_stem.stl
all: keys stems keys-without-stems

MX_DES_Standard_R1.stl: MX_DES_Standard.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=5/' MX_DES_Standard.scad | openscad -q --export-format binstl -o $@ /dev/stdin
MX_DES_Standard_R1_key_without_stem.stl: MX_DES_Standard.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=5/' -e '1,30s/Stem *= *true/Stem = false/' MX_DES_Standard.scad | openscad -q --export-format binstl -o $@ /dev/stdin
MX_DES_Standard_R1_stem.stl: MX_DES_Standard.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=5/' -e '1,30s/keycap(/stem_only(/' MX_DES_Standard.scad | openscad -q --export-format binstl -o $@ /dev/stdin

MX_DES_Standard_R2.stl: MX_DES_Standard.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=2/' MX_DES_Standard.scad | openscad -q --export-format binstl -o $@ /dev/stdin
MX_DES_Standard_R2_key_without_stem.stl: MX_DES_Standard.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=2/' -e '1,30s/Stem *= *true/Stem = false/' MX_DES_Standard.scad | openscad -q --export-format binstl -o $@ /dev/stdin
MX_DES_Standard_R2_stem.stl: MX_DES_Standard.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=2/' -e '1,30s/keycap(/stem_only(/' MX_DES_Standard.scad | openscad -q --export-format binstl -o $@ /dev/stdin

MX_DES_Standard_R3.stl: MX_DES_Standard.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=1/' MX_DES_Standard.scad | openscad -q --export-format binstl -o $@ /dev/stdin
MX_DES_Standard_R3_key_without_stem.stl: MX_DES_Standard.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=1/' -e '1,30s/Stem *= *true/Stem = false/' MX_DES_Standard.scad | openscad -q --export-format binstl -o $@ /dev/stdin
MX_DES_Standard_R3_stem.stl: MX_DES_Standard.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=1/' -e '1,30s/keycap(/stem_only(/' MX_DES_Standard.scad | openscad -q --export-format binstl -o $@ /dev/stdin

MX_DES_Standard_R3_deepdish.stl: MX_DES_Standard.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=3/' MX_DES_Standard.scad | openscad -q --export-format binstl -o $@ /dev/stdin
MX_DES_Standard_R3_deepdish_key_without_stem.stl: MX_DES_Standard.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=3/' -e '1,30s/Stem *= *true/Stem = false/' MX_DES_Standard.scad | openscad -q --export-format binstl -o $@ /dev/stdin
MX_DES_Standard_R3_deepdish_stem.stl: MX_DES_Standard.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=3/' -e '1,30s/keycap(/stem_only(/' MX_DES_Standard.scad | openscad -q --export-format binstl -o $@ /dev/stdin

MX_DES_Standard_R4.stl: MX_DES_Standard.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=0/' MX_DES_Standard.scad | openscad -q --export-format binstl -o $@ /dev/stdin
MX_DES_Standard_R4_key_without_stem.stl: MX_DES_Standard.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=0/' -e '1,30s/Stem *= *true/Stem = false/' MX_DES_Standard.scad | openscad -q --export-format binstl -o $@ /dev/stdin
MX_DES_Standard_R4_stem.stl: MX_DES_Standard.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=0/' -e '1,30s/keycap(/stem_only(/' MX_DES_Standard.scad | openscad -q --export-format binstl -o $@ /dev/stdin

MX_DES_Standard_R5.stl: MX_DES_Standard.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=4/' MX_DES_Standard.scad | openscad -q --export-format binstl -o $@ /dev/stdin
MX_DES_Standard_R5_key_without_stem.stl: MX_DES_Standard.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=4/' -e '1,30s/Stem *= *true/Stem = false/' MX_DES_Standard.scad | openscad -q --export-format binstl -o $@ /dev/stdin
MX_DES_Standard_R5_stem.stl: MX_DES_Standard.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=4/' -e '1,30s/keycap(/stem_only(/' MX_DES_Standard.scad | openscad -q --export-format binstl -o $@ /dev/stdin

MX_DES_Thumb_3.stl: MX_DES_Thumb.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=3/' MX_DES_Thumb.scad | openscad -q --export-format binstl -o $@ /dev/stdin
MX_DES_Thumb_3_key_without_stem.stl: MX_DES_Thumb.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=3/' -e '1,30s/Stem *= *true/Stem = false/' MX_DES_Thumb.scad | openscad -q --export-format binstl -o $@ /dev/stdin
MX_DES_Thumb_3_stem.stl: MX_DES_Thumb.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=3/' -e '1,30s/keycap(/stem_only(/' MX_DES_Thumb.scad | openscad -q --export-format binstl -o $@ /dev/stdin

MX_DES_Thumb_4.stl: MX_DES_Thumb.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=4/' MX_DES_Thumb.scad | openscad -q --export-format binstl -o $@ /dev/stdin
MX_DES_Thumb_4_key_without_stem.stl: MX_DES_Thumb.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=4/' -e '1,30s/Stem *= *true/Stem = false/' MX_DES_Thumb.scad | openscad -q --export-format binstl -o $@ /dev/stdin
MX_DES_Thumb_4_stem.stl: MX_DES_Thumb.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=4/' -e '1,30s/keycap(/stem_only(/' MX_DES_Thumb.scad | openscad -q --export-format binstl -o $@ /dev/stdin

MX_DES_Thumb_5.stl: MX_DES_Thumb.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=5/' MX_DES_Thumb.scad | openscad -q --export-format binstl -o $@ /dev/stdin
MX_DES_Thumb_5_key_without_stem.stl: MX_DES_Thumb.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=5/' -e '1,30s/Stem *= *true/Stem = false/' MX_DES_Thumb.scad | openscad -q --export-format binstl -o $@ /dev/stdin
MX_DES_Thumb_5_stem.stl: MX_DES_Thumb.scad
	sed -e '1,30s/keyID *= [0-9]*/keyID=5/' -e '1,30s/keycap(/stem_only(/' MX_DES_Thumb.scad | openscad -q --export-format binstl -o $@ /dev/stdin

