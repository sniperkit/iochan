package main

import (
	"bytes"
	"fmt"

	iochan "github.com/sniperkit/iochan/pkg"
	pp "github.com/sniperkit/pp/pkg"
)

var VERSION string

func main() {
	fmt.Println("iochan - example running...")

	buf := new(bytes.Buffer)
	buf.WriteString("foo\nbar\nbaz")

	ch := iochan.DelimReader(buf, '\n')
	results := make([]string, 0, 3)
	expected := []string{"foo\n", "bar\n", "baz"}
	for v := range ch {
		results = append(results, v)
	}

	pp.Println("results=", results)
	pp.Println("expected=", expected)

}
