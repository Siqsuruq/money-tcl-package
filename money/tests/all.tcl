package require tcltest
::tcltest::configure -testdir [pwd] -file "*.test"
::tcltest::runAllTests
