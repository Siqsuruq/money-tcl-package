package require nx
package require math::decimal

nx::Object create money {
    # Class properties
    :object property {version "1.0.1"}
    :object property {description "Simple Money Package, using math::decimal"}
    :object property {round_digits 2}

    # Constructor
    :init {} {}

    # Public method to set round_digits
    :public object method setRoundDigits {digits} {
        :round_digits $digits
    }

    # Public method to get round_digits
    :public object method getRoundDigits {} {
        return ${:round_digits}
    }

    # Public method: Add Percent
    :public object method addPercent {value percent} {
        set val [::math::decimal::fromstr $value]
        set pr [::math::decimal::fromstr $percent]
        set h [::math::decimal::fromstr 100]

        set onepr [::math::decimal::divide $val $h]
        set fullper [::math::decimal::multiply $onepr $pr]
        set result [::math::decimal::add $fullper $val]

        return [:round [::math::decimal::tostr $result]]
    }

    # Public method: Subtract Percent
    :public object method subtractPercent {value percent} {
        set val [::math::decimal::fromstr $value]
        set pr [::math::decimal::fromstr $percent]
        set h [::math::decimal::fromstr 100]

        set onepr [::math::decimal::divide $val $h]
        set fullper [::math::decimal::multiply $onepr $pr]
        set result [::math::decimal::subtract $val $fullper]

        return [:round [::math::decimal::tostr $result]]
    }

    # Public method: Add
    :public object method add {a b} {
        set vala [::math::decimal::fromstr $a]
        set valb [::math::decimal::fromstr $b]
        set result [::math::decimal::add $vala $valb]
        return [:round [::math::decimal::tostr $result]]
    }

    # Public method: Subtract
    :public object method subtract {a b} {
        set vala [::math::decimal::fromstr $a]
        set valb [::math::decimal::fromstr $b]
        set result [::math::decimal::subtract $vala $valb]
        return [:round [::math::decimal::tostr $result]]
    }

    # Public method: Multiply
    :public object method multiply {a b} {
        set vala [::math::decimal::fromstr $a]
        set valb [::math::decimal::fromstr $b]
        set result [::math::decimal::multiply $vala $valb]
        return [:round [::math::decimal::tostr $result]]
    }

    # Public method: Divide
    :public object method divide {a b} {
        set vala [::math::decimal::fromstr $a]
        set valb [::math::decimal::fromstr $b]
        set result [::math::decimal::divide $vala $valb]
        return [:round [::math::decimal::tostr $result]]
    }

    # Public method: Round
    :public object method round {val {round_digits ""}} {
        if {$round_digits eq ""} {
            set round_digits ${:round_digits}
        }
        set valr [::math::decimal::fromstr $val]
        return [::math::decimal::tostr [::math::decimal::round_half_even $valr $round_digits]]
    }
	
	:public object method version {} {
		return ${:version}
	}
}

# Provide the package
package provide money [money version]
