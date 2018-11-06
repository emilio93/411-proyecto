package main

import (
  "fmt"
  "regexp"
  "os"
  "log"
  "io/ioutil"
)

func main() {


  file, err := os.Open("../tests/adapter_4_to_1_tb.vcd") // For read access.
  if err != nil {
    log.Fatal(err)
  }

  b, err := ioutil.ReadAll(file)
  if err != nil {
    fmt.Print(err)
  }
  str := string(b) // convert content to a 'string'
  // fmt.Println(str) // print the content as a 'string'

  // Compile the expression once, usually at init time.
  // Use raw strings to avoid having to quote the backslashes.
  re1 := regexp.MustCompile(`[\$]timescale\s*.*?\s*(?P<timescale>\d+[a-z]+)\s*.*?\s*[\$]end`)
	re2 := regexp.MustCompile(`[\$]date\s*.*?\s*(?P<date>[a-zA-Z0-9: ]+)\s*.*?\s*[\$]end`)
	re3 := regexp.MustCompile(`[\$]version\s*.*?\s*([a-zA-Z0-9: ]+)\s*.*?\s*[\$]end`)

  groupNames1 := re1.SubexpNames()
  for matchNum, match := range re1.FindAllStringSubmatch(str, -1) {
    for groupIdx, group := range match {
        name := groupNames1[groupIdx]
        if name == "" {
            name = "*"
        }
        fmt.Printf("#%d text: '%s', group: '%s'\n", matchNum, group, name)
    }
  }

  groupNames2 := re2.SubexpNames()
  for matchNum, match := range re2.FindAllStringSubmatch(str, -1) {
    for groupIdx, group := range match {
        name := groupNames2[groupIdx]
        if name == "" {
            name = "*"
        }
        fmt.Printf("#%d text: '%s', group: '%s'\n", matchNum, group, name)
    }
  }

  groupNames3 := re3.SubexpNames()
  for matchNum, match := range re3.FindAllStringSubmatch(str, -1) {
    for groupIdx, group := range match {
        name := groupNames3[groupIdx]
        if name == "" {
            name = "*"
        }
        fmt.Printf("#%d text: '%s', group: '%s'\n", matchNum, group, name)
    }
  }
}
