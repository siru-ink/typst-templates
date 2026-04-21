#let letter(
  // Title of the person sending the letter
  sender-name: "",
  // Physical mail address of the person sending the letter
  sender-address: none,
  // Email address of the person sending the letter
  sender-email: "",
  // Title of the person receiving the letter
  receiver-name: "",
  // Physical mail address of the person receiving the letter
  receiver-address: none,
  // Email address of the person receiving the letter
  receiver-email: "",
  // Date (and optional location) line for the letter
  date: "",
  // Single subject line describing the letter
  subject-line: "",
  // Opening words for the letter (e.g. "Dear ...", "To whom it may concern ...")
  salutation: "",
  // Closing words for the letter (e.g. "Sincerely ...", "Best ...")
  closing: "",
  // spellchecking language to use
  lang: "de",
  // Reference path to a digital image of the signature of the letter sender
  signature-image: none,
  // Listing of attachments that will be send along with the letter (e.g. "("Resume", ...)")
  attachments: none,
  // Body text content
  content,
) = {
  // Variables used to create standard spacing
  let item-spacing = 1cm
  let page-margin = 2cm

  // Adding pdf metadata properties
  set document(author: sender-name, title: subject-line)

  // Set up output page properties
  set page("a4", margin: page-margin)

  // Set up default text properties
  set text(font: "New Computer Modern", size: 11pt, lang: lang)

  // Always show links visually
  show link: underline

  // Sender information on top right of letter
  grid(
    columns: (1fr, auto),
    rows: (auto, auto),
    gutter: 8pt,
    [], text(weight: 700, sender-name),
    [], if sender-email != none { link("mailto:" + sender-email, sender-email) } else { sender-address },
  )

  v(item-spacing * 0.5)

  // Receiver information on left of letter
  text(weight: 700, receiver-name)
  linebreak()
  if receiver-email != none {
    link("mailto:" + receiver-email, receiver-email)
  } else {
    receiver-address
  }

  v(item-spacing * 1.5)

  // Date (and place) on right of letter
  grid(
    columns: (1fr, auto),
    rows: auto,
    gutter: 8pt,
    [], text(weight: 700, date),
  )

  v(item-spacing)

  // Subject line
  text(weight: 700, size: 14pt, subject-line)

  v(item-spacing)

  // Opening words
  salutation + ","
  linebreak()

  v(item-spacing)

  // Main body content
  content
  linebreak()

  v(item-spacing)

  // Closing words, with an optional signature image
  closing
  linebreak()
  if signature-image != none {
    v(item-spacing)
    image(signature-image, height: 1cm)
  }
  sender-name

  v(1fr)

  // Optional listing of attachments following the letter
  if attachments != none {
    text(weight: 700, "Anhänge:")
    linebreak()
    for item in attachments {
      [- #item]
    }
  }


  // Folding marks for folding a4 letter into thirds
  place(
    top + left,
    dx: -page-margin / 2,
    dy: 105mm - page-margin,
    line(length: 5mm, stroke: 0.5pt + black),
  )
  place(
    top + left,
    dx: -page-margin / 2,
    dy: 210mm - page-margin,
    line(length: 5mm, stroke: 0.5pt + black),
  )

  // Debugging only. Showing where the window in a standard DIN 5008-B envelope would be expected to
  // be see-thru. Used for receiver address positioning
  // place(
  //   top + left,
  //   dx: 20mm - page-margin, dy: 27mm - page-margin,
  //   rect(width: 85mm, height: 45mm)
  // )
}
