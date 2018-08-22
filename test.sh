#!/bin/bash

gmt gmtset PS_MEDIA 21.0cx29.7c #A4=21.0cx29.7c
gmt gmtset FONT_TITLE 22p,5,0/0/0
gmt gmtset FONT_LABEL 18p,5,0/0/0
gmt gmtset FONT_ANNOT_PRIMARY 14p,4,0/0/0

grdsrtm="/home/anupam/ETOPO1/srtm15/topo15.grd"
grdetopo1="/home/anupam/ETOPO1/ETOPO1_Bed_g_gmt4.grd"

myTopo="input.grd"
myTopoInt="input_int.grd"

myTopo1="input1.grd"
myTopoInt1="input_int1.grd"

#gmt grdcut ${grdsrtm} -R-88/-60/10/24 -G${myTopo}
#gmt grdcut ${grdetopo1} -R-88/-60/10/24 -G${myTopo1}

#gmt grdclip ${myTopo} -Gcat_srtm.grd -Sb-0.1/NaN -V
#gmt grdclip ${myTopo1} -Gcat_etopo1.grd -Sa-1/NaN -V

#grdsample cat_srtm.grd -I5s -Gcat_srtm1.grd -R-88/-60/10/24 -r
#grdsample cat_etopo1.grd -I5s -Gcat_etopo11.grd -R-88/-60/10/24 -r 

#grdmath -N cat_srtm1.grd cat_etopo11.grd AND = srtm_etopo1.grd

gmt grdgradient srtm_etopo1.grd -Gsrtm_etopo.grd  -Ne -A0/270

##gmt grdgradient cat_srtm.grd -G${myTopoInt}  -Ne -A0/270
##gmt grdgradient cat_etopo1.grd -G${myTopoInt1}  -Ne -A0/270


gmt psbasemap -R-88/-60/10/24 -JC17c -Bxa3f3 -Bya3f3 -BENSW -P -X2.3c -Y3.0c -K > plot.ps

#gmt makecpt -Crelief.cpt -T0/8000/500 -Z > topoo.cpt

gmt grdimage srtm_etopo1.grd -R -J -Isrtm_etopo.grd -Cetopo1.cpt -P -O -K >> plot.ps

##gmt grdimage cat_etopo1.grd -R -J -I${myTopoInt1} -Cjet.cpt -P -O  >> plot.ps


awk '{print($2,$1)}' lat.txt | psxy -R -J -W1 -Sc0.2 -Gred -O  >> plot.ps

gmt psconvert plot.ps -Tg -E2000

