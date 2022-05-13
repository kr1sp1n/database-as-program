namespace eval ::LOL {
  namespace export test
}

proc ::LOL::test {} {
  puts "LOL"
}

package provide LOL 1.0.0