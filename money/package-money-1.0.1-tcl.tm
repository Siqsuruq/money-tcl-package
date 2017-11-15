# ACTIVESTATE TEAPOT-PKG BEGIN TM -*- tcl -*-
# -- Tcl Module

# @@ Meta Begin
# Package money 1.0.1
# Meta category    Buisness
# Meta description 
# Meta platform    tcl
# Meta require     {Tcl 8.5}
# Meta require     math::decimal
# Meta subject     Buisness Money Decimal
# Meta summary     Simple package to deal with money
# @@ Meta End


# ACTIVESTATE TEAPOT-PKG BEGIN REQUIREMENTS

package require Tcl 8.5
package require math::decimal

# ACTIVESTATE TEAPOT-PKG END REQUIREMENTS

# ACTIVESTATE TEAPOT-PKG BEGIN DECLARE

package provide money 1.0.1

# ACTIVESTATE TEAPOT-PKG END DECLARE
# ACTIVESTATE TEAPOT-PKG END TM
package require math::decimal

# Create the namespace
namespace eval ::money {
 
# Export 
	namespace export *
	
	
# My Variables
	set version 1.0.1
	set description "Simple Money Package, using math::decimal"
	set round_digits 2
 
# Variable for the path of the script
	variable home [file join [pwd] [file dirname [info script]]]
 
}
 
# Definition of percent procedures
proc ::money::add_percent {value percent} {
	set val [::math::decimal::fromstr $value]
	set pr [::math::decimal::fromstr $percent]
	set h [::math::decimal::fromstr 100]
	
	set onepr [::math::decimal::divide $val $h]
	set fullper [::math::decimal::multiply $onepr $pr]
	set result [::math::decimal::add $fullper $val]

	return [::money::round [::math::decimal::tostr $result]]
}

proc ::money::subtract_percent {value percent} {
	set val [::math::decimal::fromstr $value]
	set pr [::math::decimal::fromstr $percent]
	set h [::math::decimal::fromstr 100]
	
	set onepr [::math::decimal::divide $val $h]
	set fullper [::math::decimal::multiply $onepr $pr]
	set result [::math::decimal::subtract $val $fullper]

	return [::money::round [::math::decimal::tostr $result]]
}

proc ::money::get_percent {value percent} {
	set val [::math::decimal::fromstr $value]
	set pr [::math::decimal::fromstr $percent]
	set h [::math::decimal::fromstr 100]
	
	set onepr [::math::decimal::divide $val $h]
	set result [::math::decimal::multiply $onepr $pr]

	return [::money::round [::math::decimal::tostr $result]]
}

proc ::money::get_100_percent {value percent} {
	set val [::math::decimal::fromstr $value]
	set pr [::math::decimal::fromstr $percent]
	set h [::math::decimal::fromstr 100]
	
	set fpr [::math::decimal::add $h $pr]
	set onepr [::math::decimal::divide $val $fpr]
	set result [::math::decimal::multiply $onepr $h]

	return [::money::round [::math::decimal::tostr $result]]
}

# Definition of basic procedures
proc ::money::add {a b} {
	set vala [::math::decimal::fromstr $a]
	set valb [::math::decimal::fromstr $b]
	set result [::math::decimal::add $vala $valb]
	return [::money::round [::math::decimal::tostr $result]]
}
proc ::money::+ {a b} {
	return [::money::add $a $b]
}

proc ::money::subtract {a b} {
	set vala [::math::decimal::fromstr $a]
	set valb [::math::decimal::fromstr $b]
	set result [::math::decimal::subtract $vala $valb]
	return [::money::round [::math::decimal::tostr $result]]
}
proc ::money::- {a b} {
	return [::money::subtract $a $b]
}

proc ::money::multiply {a b} {
	set vala [::math::decimal::fromstr $a]
	set valb [::math::decimal::fromstr $b]
	set result [::math::decimal::multiply $vala $valb]
	return [::money::round [::math::decimal::tostr $result]]
}
proc ::money::* {a b} {
	return [::money::multiply $a $b]
}

proc ::money::divide {a b} {
	set vala [::math::decimal::fromstr $a]
	set valb [::math::decimal::fromstr $b]
	set result [::math::decimal::divide $vala $valb]
	return [::money::round [::math::decimal::tostr $result]]
}
proc ::money::/ {a b} {
	return [::money::divide $a $b]
}

proc ::money::round {val {round_digits ""}} {
	if {$round_digits eq ""} {
		set round_digits $::money::round_digits
	}
	set valr [::math::decimal::fromstr $val]
	return [::math::decimal::tostr [::math::decimal::round_half_even $valr $round_digits]]
}

proc money::change {amount value} {
	return [::money::subtract $amount $value]
}

proc money::average {vlist} {
	set ll [llength $vlist]
	set f [::math::decimal::fromstr 0]
	for {set i 0} {$i < $ll} {incr i} {
		set f [::math::decimal::add [::math::decimal::fromstr [lindex $vlist $i]] $f]
	}
	return [::money::round [::math::decimal::tostr [::math::decimal::divide $f [::math::decimal::fromstr $ll]]]]
}

proc money::percentagechange {orig new} {
	set vala [::math::decimal::fromstr $orig]
	set valb [::math::decimal::fromstr $new]
	set h [::math::decimal::fromstr 100]
	
	set diff [::math::decimal::subtract $vala $valb]
	set diffoneper [::math::decimal::divide $diff $vala]
	set result [::math::decimal::multiply $diffoneper $h]
	set status [::math::decimal::is-signed $result]
	if {$status == 1} {
		set st "increase"
		set result [::math::decimal::copynegate $result]
	} elseif {$status == 0} {set st "decrease"}
	
	return "$st [::money::round [::math::decimal::tostr $result]]"
}

package provide money $money::version
package require Tcl 8.5