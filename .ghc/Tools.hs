module Tools where

toBase :: Integral a => a -> a -> [a]
toBase b n = reverse . tail . takeDigits $ iterate (flip divMod b . fst) (n, 0)
    where takeDigits = foldr (\(a,b) acc -> if a>0 then b:acc else [b]) []

digits = ['0'..'9'] ++ ['a'..'z']

toBaseStr :: Integral a => a -> a -> String
toBaseStr = (map ((digits !!) . fromIntegral) .) . toBase

bin = toBaseStr 2
oct = toBaseStr 8
dec = toBaseStr 10
hex = toBaseStr 16
