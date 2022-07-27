#!/usr/bin/env ruby
require 'json'

def check s, k
    puts "warning: #{s} bad (in #{k})" if s !~ /^#{'#STKPWHR-FRPBLGTSDZ'.gsub(/./,'\0?').sub '-?', '(A?O?\*?E?U?|-)'}$/
    s
end

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
MP-   KPW
NT-   SPW
NV-   STW

B-    PW
C-    KR
D-    TK
F-    TP
G-    TKPW
J-    SKWR
L-    HR
M-    PH
N-    TPH
V-    SR
X-    KP
Y-    KWR

-KSHN BGS

-NCH  FRPBLG
-RCH  FRPB
-SHN  GS

-CH   FP
-ML   FRL
-MP   FRP
-MB   FRB
-RV   FRB
-SH   RB

-J    PBLG
-K    BG
-M    PL
-N    PB
-X    BGS

-H    FPLT

'.gsub(/^-/, '[AO*EU-].*\K').gsub('- ', '(?=.*[AO*EU-]) ').lines.map(&:chomp).reject(&:empty?).map{|x| a,b = x.split; [Regexp.new(a), b]}

rep = '²³⁴⁵⁶⁷⁸⁹'
preg = /\(([^)]+)\)/
qqeg = /(.)\?\?/
qreg = /(.)\?/
oreg = /(.)\|(.)/
process = -> s {
    s =~ preg ? (process[s.sub(preg, '')] + process[s.sub(preg, '\1')]) :
    s =~ qqeg ? (process[s.sub(qqeg, ?-)] + process[s.sub(qqeg, '\1')]) :
    s =~ qreg ? (process[s.sub(qreg, '')] + process[s.sub(qreg, '\1')]) :
    s =~ oreg ? (process[s.sub(oreg, '\1')] + process[s.sub(oreg, '\2')]) :
    rep.index(s[-1]) ? [([s[0..-2]] * (rep.index(s[-1]) + 2)) * ?/] :
    [s]
}

File.write 'dict.json',
    File.readlines('dict')
        .map(&:strip)
        .reject{|x| x.empty? || x[0] == ?# }
        .flat_map{|x|
            parts = x.split '; '
            a,b = parts[mid = parts.size/2].split nil, 2
            (parts[0...mid] + [a]).zip([b] + parts[mid+1..-1])
        }
        .flat_map{|x| a,b = x; a.split(?,).map{|a| [a,b.sub(/ +# .*/, '')]} }
        .flat_map{|x| a,b = x; groups = []; process[a.gsub(/\[([^\]]+)\]/) { groups.push $1; "#{groups.size-1}" }].map{|a| [a.gsub(/[0-9]/) {|d| groups[d.to_i] },b]} }
        .flat_map{|x| a,b = x; groups = []; process[a.gsub(/\[([^\]]+)\]/) { groups.push $1; "#{groups.size-1}" }].map{|a| [a.gsub(/[0-9]/) {|d| groups[d.to_i] },b]} }
        .to_h
        .transform_keys{|k| k.sub(/^\\#/, ?#).split(?/).map{|s| check subs.reduce(s){|s,r| s.gsub *r}, k}*?/ }
        .to_json
