import sys
from bs4 import BeautifulSoup

try:
    file = sys.argv[1]
except IndexError:
    # If input comes from stdin, we are creating the final HTML code that goes into the
    # slide, therefore we start with ## References, and split up on every fourth
    # reference
    print("## References")
    soup = BeautifulSoup(sys.stdin, features="lxml")
    div = soup.find("div", id="refs")
    d_list = div.contents
    # All even-indexed elements are newline characters
    del d_list[::2]
    for i, element in enumerate(d_list):
        if i > 0 and i % 4 == 0:
            print("--")
        print(element)
        print('<!-- .element: style="font-size:20pt" -->')
    # print('\n<!-- .element: style="font-size:20pt" -->\n'.join(map(str, d_list)))
    # Join only adds the string in between, so we need one extra at the end
    # print('<!-- .element: style="font-size:20pt" -->')
else:
    with open(file, "r") as fp:
        soup = BeautifulSoup(fp, features="lxml")
    for link in soup.find_all('a'):
        print(link.get('data-citation-key'))
