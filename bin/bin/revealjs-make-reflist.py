import sys
from bs4 import BeautifulSoup

try:
    file = sys.argv[1]
except IndexError:
    # If input comes from stdin, we are creating the final HTML code that goes into the
    # slide, therefore we start with ## References, and split up on every fourth
    # reference
    soup = BeautifulSoup(sys.stdin, features="lxml")
    div = soup.find("div", id="refs")
    if hasattr(div, "contents"):
        print("---")
        print("")
        print("## References\n")
        d_list = div.contents
        # All even-indexed elements are newline characters
        del d_list[::2]
        new_page = False
        i = 0
        wc = 0
        for element in d_list:
            wc += len(element.get_text())
            if wc > 1000 or (i > 0 and i % 4 == 0):
                print("\n--\n")
                i += 1
                wc = 0
            print('- <!-- .element: style="font-size:20pt" -->')
            print(element)
else:
    with open(file, "r") as fp:
        soup = BeautifulSoup(fp, features="lxml")
    for link in soup.find_all("a"):
        print(link.get("data-citation-key"))
