#let resume(
  name: "",
  address: "",
  telephone: "",
  email: "",
  citizenship: "",
  place-of-birth: "",
  date-of-birth: "",
  accent-color: "#020079",
  lang: "de",
  body
) = {
  // Sets document metadata
  set document(author: name, title: "Lebenslauf " + name)

  // Document-wide formatting, including font and margins
  set text(
    font: "New Computer Modern",
    size: 11pt,
    lang: lang,
    ligatures: false
  )

  // Set page layout
  set page(
    margin: (2cm),
    paper: "a4",
  )

  // Add header from page 2 onwards
  set page(header: context {
    if counter(page).get().first() > 1 {
      h(1fr) + name + h(5pt) + sym.bar.v + h(5pt) + email + h(5pt) + sym.bar.v + h(5pt) + "Lebenslauf " + str(counter(page).get().first()) + sym.slash + str(counter(page).final().first())
    }
})

  // Give links an underline like the web
  show link: underline

  // Color sub-headings and links with accent color
  show heading: set text(
    fill: rgb(accent-color),
  )
  show link: set text(
    fill: rgb(accent-color),
  )

  // Add name as page title on left
  show heading.where(level: 1): it => [
    #set align(left)
    #set text(
      weight: 700,
      size: 20pt,
    )
    #pad(it.body)
  ]

  // Small caps for section titles
  // show heading.where(level: 2): it => [
  //   #pad(top: 0pt, bottom: 10pt, [#smallcaps(it.body)])
  // ]
  show heading.where(level: 2): it => [
    #pad(top: 0pt, bottom: 8pt, it.body)
  ]

  // Level 1 Heading
  [= #name]

  v(8pt)

  if lang == "en" {
    [
      *Address:* #address \
      *Mobile:* #telephone \
      *Email:* #email
    ]
  } else {
    [
      *Anschrift:* #address \
      *Tel/Mobil:* #telephone \
      *E-Mail:* #email
    ]
  }

  v(8pt)

  if lang == "en" {
    [
      *Birthplace:* #place-of-birth \
      *Birthday:* #date-of-birth \
      *Citizenship:* #citizenship
    ]
  } else {
    [
      *Geburtsort:* #place-of-birth \
      *Geburtstag:* #date-of-birth \
      *Staatsangehörigkeit:* #citizenship
    ]
  }

  v(8pt)

  line(start: (0%,0%), end: (100%,0%))

  v(8pt)

  body
}

#let line-helper() = {
  line(start: (0%,0%), end: (100%,0%))
}

#let date-helper(start,end) = {
  start + " " + sym.dash.en + " " + end
}

#let edu(
  dates: none,
  degree: none,
  institution: none,
  grade: none,
  content
) = {
  let degree-line = {
    if grade != none {
      text(weight: 700, degree) + h(5pt) + sym.bar.v + h(5pt) + grade
    } else {
      text(weight: 700, degree)
    }
  }

  grid(
    columns: (1fr, 3fr),
    rows: (auto, auto),
    gutter: 8pt,
    dates, degree-line,
    [],institution + linebreak() + content,
  )
}

#let work(
  dates: none,
  job-title: none,
  business-name: none,
  content
) = {
  grid(
    columns: (1fr,3fr),
    rows: (auto,auto,auto),
    gutter: 8pt,
    dates,text(weight: 700, job-title) + linebreak() + business-name + linebreak() + content,
  )
}

#let project(
  dates: none,
  link-text: none,
  link-source: "example.com",
  name: none,
  content
) = {
  grid(
    columns: (1fr,3fr),
    rows: auto,
    gutter: 8pt,
    link(link-source, link-text), text(weight: 700, name) + linebreak() + content,
  )
}

#let skill(
  skill-group-name: none,
  skill-listing: none,
) = {
  grid(
    columns: (2fr,4fr),
    rows: auto,
    gutter: 8pt,
    text(weight: 700, skill-group-name + ":"), skill-listing
  )
}

#let signature(
  signature-image-path: "signature.png",
  body
) = {
  v(1fr)
  image("signature.png", height: 1cm)
  v(-10pt)
  line(start: (0%,0%), end: (7cm,0%))
  v(-8pt)
  body
}
