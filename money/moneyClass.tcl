package require nx
package require math::decimal

nx::Object create money {
    # Class properties
    :object property {version "1.0.2"}
    :object property {description "Simple Money Package, using math::decimal"}
    :object property -accessor public {round_digits 2}

    # Constructor
    :init {} {}

    # Public method to set round_digits
    :public object method setRoundDigits {digits} {
		set :round_digits $digits
    }

    # Public method to get round_digits
    :public object method getRoundDigits {} {
        return ${:round_digits}
    }

    # Public method: Add Percent
    :public object method addPercent {value percent} {
		try {
			set val [::math::decimal::fromstr $value]
			set pr [::math::decimal::fromstr $percent]
			set h [::math::decimal::fromstr 100]

			set onepr [::math::decimal::divide $val $h]
			set fullper [::math::decimal::multiply $onepr $pr]
			set result [::math::decimal::add $fullper $val]

			return [:round [::math::decimal::tostr $result]]
		} on error {errMsg} {
			return -code error $errMsg
			
		}
    }

    # Public method: Subtract Percent
    :public object method subtractPercent {value percent} {
		try {
			set val [::math::decimal::fromstr $value]
			set pr [::math::decimal::fromstr $percent]
			set h [::math::decimal::fromstr 100]

			set onepr [::math::decimal::divide $val $h]
			set fullper [::math::decimal::multiply $onepr $pr]
			set result [::math::decimal::subtract $val $fullper]

			return [:round [::math::decimal::tostr $result]]
		} on error {errMsg} {
			return -code error $errMsg
			
		}

    }
	
	:public object method getPercent {value percent} {
		try {
			set val [::math::decimal::fromstr $value]
			set pr [::math::decimal::fromstr $percent]
			set h [::math::decimal::fromstr 100]
			
			set onepr [::math::decimal::divide $val $h]
			set result [::math::decimal::multiply $onepr $pr]

			return [:round [::math::decimal::tostr $result]]
		} on error {errMsg} {
			return -code error $errMsg
		}
	}
	
	:public object method get100Percent {value percent} {
		try {
			set val [::math::decimal::fromstr $value]
			set pr [::math::decimal::fromstr $percent]
			set h [::math::decimal::fromstr 100]
			
			set fpr [::math::decimal::add $h $pr]
			set onepr [::math::decimal::divide $val $fpr]
			set result [::math::decimal::multiply $onepr $h]

			return [:round [::math::decimal::tostr $result]]
		} on error {errMsg} {
			return -code error $errMsg
		}

	}
	
    # Public method: Add
    :public object method add {a b} {
		try {
			set vala [::math::decimal::fromstr $a]
			set valb [::math::decimal::fromstr $b]
			set result [::math::decimal::add $vala $valb]
			return [:round [::math::decimal::tostr $result]]
		} on error {errMsg} {
			return -code error $errMsg
		}
    }

    # Public method: Subtract
    :public object method subtract {a b} {
		try {
			set vala [::math::decimal::fromstr $a]
			set valb [::math::decimal::fromstr $b]
			set result [::math::decimal::subtract $vala $valb]
			return [:round [::math::decimal::tostr $result]]			
		} on error {errMsg} {
			return -code error $errMsg
		}
    }

    # Public method: Multiply
    :public object method multiply {a b} {
		try {
			set vala [::math::decimal::fromstr $a]
			set valb [::math::decimal::fromstr $b]
			set result [::math::decimal::multiply $vala $valb]
			return [:round [::math::decimal::tostr $result]]
		} on error {errMsg} {
			return -code error $errMsg
		}
    }

    # Public method: Divide
    :public object method divide {a b} {
		try {
			set vala [::math::decimal::fromstr $a]
			set valb [::math::decimal::fromstr $b]
			if {[::math::decimal::is-zero [::math::decimal::fromstr $b]]} {
				return -code error "Division by zero is not allowed."
			} else {
				set result [::math::decimal::divide $vala $valb]
				return [:round [::math::decimal::tostr $result]]
			}
		} on error {errMsg} {
			return -code error $errMsg
		}
    }

    # Public method: Round
    :public object method round {val {round_digits ""}} {
		try {
			if {$round_digits eq ""} {
				set round_digits ${:round_digits}
			}
			set valr [::math::decimal::fromstr $val]
			return [::math::decimal::tostr [::math::decimal::round_half_even $valr $round_digits]]
		} on error {errMsg} {
			return -code error $errMsg
		}
    }
	
	:public object method change {amount value} {
		try {
			return [:subtract $amount $value]
		} on error {errMsg} {
			return -code error $errMsg
		}
	}
	
	:public object method average {vlist} {
		try {
			set ll [llength $vlist]
			set f [::math::decimal::fromstr 0]
			for {set i 0} {$i < $ll} {incr i} {
				set f [::math::decimal::add [::math::decimal::fromstr [lindex $vlist $i]] $f]
			}
			return [:round [::math::decimal::tostr [::math::decimal::divide $f [::math::decimal::fromstr $ll]]]]
		} on error {errMsg} {
			return -code error $errMsg
		}
	}
	
	:public object method percentagechange {orig new} {
		try {
			# Convert inputs to decimal
			set vala [::math::decimal::fromstr $orig]
			set valb [::math::decimal::fromstr $new]
			set h [::math::decimal::fromstr 100]

			# Check if the original value is zero
			if {[::math::decimal::is-zero $vala]} {
				return "Error: Percentage change cannot be calculated when the original value is zero."
			}

			# Calculate the difference and percentage change
			set diff [::math::decimal::subtract $valb $vala]
			set diffoneper [::math::decimal::divide $diff $vala]
			set result [::math::decimal::multiply $diffoneper $h]

			# Determine the sign
			set sign "+"
			if {[::math::decimal::is-signed $result]} {
				set sign "-"
				set result [::math::decimal::copynegate $result]
			}

			# Return the result in the desired format
			return "$sign[:round [::math::decimal::tostr $result]]%"
		} on error {errMsg} {
			return -code error $errMsg
		}
	}
	
	:public object method version {} {
		return ${:version}
	}
}

# Provide the package
package provide money [money version]
