package version

import "strings"

const VERSION = "0.26.11"

// Compulsory minimum version, Minimum downward compatibility to this version
func GetVersion() string {
	return strings.Join([]string{strings.Split(VERSION, ".")[0], strings.Split(VERSION, ".")[1], "0"}, ".")
}
