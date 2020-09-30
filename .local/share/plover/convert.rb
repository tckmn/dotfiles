#!/usr/bin/env ruby
require 'json'

subs = '

A_\*  A*EU
A_    AEU
O_\*  O*E
O_    OE
E_\*  AO*E
E_    AOE
U_\*  AO*U
U_    AOU
I_\*  AO*EU
I_    AOEU
I     EU
OO    AO

CH-   KH
NT-   SPW

B-    PW
C-    KR
D-    TK
F-    TP
G-    TPKW
J-    SKWR
L-    HR
M-    PH
N-    TPH
V-    SR
X-    KP
Y-    KWR

-KSHN BGS
-MP   FRP
-NCH  FRPB
-RCH  FRPB
-SHN  GS

-CH   FP
-J    PBLG
-K    BG
-M    PL
-N    PB
-RV   FRB
-SH   RB
-X    BGS

'.gsub(/^-/, '[AO*EU-].*\K').gsub('- ', '(?=.*[AO*EU-]) ').lines.map(&:chomp).reject(&:empty?).map{|x| a,b = x.split; [Regexp.new(a), b]}

File.write 'dict.json',
    File.readlines('dict')
        .map(&:strip)
        .reject{|x| x.empty? || x[0] == ?#}
        .map{|x| x.sub(/^\\#/, ?#).split nil, 2}.to_h
        .transform_keys{|k| k.split(?/).map{|s| subs.reduce(s){|s,r| s.gsub *r}}*?/ }
        .to_json
