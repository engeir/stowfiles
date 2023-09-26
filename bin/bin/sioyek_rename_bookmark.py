import sys
import subprocess
from sioyek.sioyek import DocumentPos, Sioyek, clean_path


def rename_bookmark(text: str, focus=False) -> None:
    # Line 327 and 375
    # s = Sioyek()
    SIOYEK_PATH = clean_path(sys.argv[1])
    LOCAL_DATABASE_PATH = clean_path(sys.argv[2])
    SHARED_DATABASE_PATH = clean_path(sys.argv[3])
    FILE_PATH = clean_path(sys.argv[4])
    # rect_string = sys.argv[5]
    # bookmark = sys.argv[5]

    s = Sioyek(SIOYEK_PATH, LOCAL_DATABASE_PATH, SHARED_DATABASE_PATH)
    doc = s.get_document(FILE_PATH)
    # s.goto_bookmark(True)
    bms = doc.get_bookmarks()
    # Seems like doc.get_bookmarks() needs to be run before?
    s.add_bookmark("new one")
    # bookmark = bms[0]
    subprocess.run(["notify-send", rf"{bms[0].get_document_position()}"])
    subprocess.run(["notify-send", rf"{bms[1].get_document_position()}"])
    subprocess.run(["notify-send", rf"{bms[2].get_document_position()}"])
    subprocess.run(["notify-send", rf"{bms[3].get_document_position()}"])
    subprocess.run(["notify-send", rf"{bms[4].get_document_position()}"])
    subprocess.run(["notify-send", rf"{bms[0]}"])
    subprocess.run(["notify-send", rf"{bms[1]}"])
    subprocess.run(["notify-send", rf"{bms[2]}"])
    subprocess.run(["notify-send", rf"{bms[3]}"])
    subprocess.run(["notify-send", rf"{bms[4]}"])
    subprocess.run(["notify-send", rf"{doc.doc}"])
    # document_pos = DocumentPos(page, 0, bookmark.rect.top_left.y)
    # s.delete_bookmark()
    # selected_page, selected_rect = parse_rect(rect_string)

    # document.remove_annotations(selected_page, selected_rect)
    s.reload()


if __name__ == "__main__":
    rename_bookmark("hehe")
    sioyek_path = clean_path(sys.argv[1])
    text = sys.argv[2]
    sio = Sioyek(sioyek_path)
    # translator = Translator()
    # translation = translator.translate(text, dest='en')
    sio.set_status_string("hihihi")
