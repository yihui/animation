library(testit)

no_nav = "'controls': ['first', 'previous', 'play', 'next', 'last', 'loop', 'speed']"
assert(
  'remove_navigator() removes the navigator from the navigation panel setting',
  no_nav == remove_navigator("'controls': ['first', 'previous', 'play', 'next', 'last', 'navigator', 'loop', 'speed']"),
  no_nav == remove_navigator(''),
  (function(x) remove_navigator(x) == x)("'controls': ['first', 'last']")
)
