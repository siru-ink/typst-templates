#let resume(
  name: "",
  location: "",
  email: "",
  git-forge: "",
  work-profile: "",
  homepage: "",
  lang: "en",
  document-meta-title: "CV",
  accent-color: "#020079",
  content,
) = {
  // Sets document metadata
  set document(author: name, title: document-meta-title + " " + name)

  // Document-wide formatting, including font and margins
  set text(
    font: "New Computer Modern",
    size: 10pt,
    lang: lang,
    ligatures: false,
  )

  // Set page layout
  set page(
    margin: 0.5in,
    paper: "us-letter",
  )

  // Give links an underline like the web
  show link: underline

  // Small caps for section titles
  show heading.where(level: 2): it => [
    #pad(top: 0pt, bottom: -10pt, [#smallcaps(it.body)])
    #line(length: 100%, stroke: 1pt)
  ]

  // Accent Color Styling
  show heading: set text(
    fill: rgb(accent-color),
  )

  show link: set text(
    fill: rgb(accent-color),
  )

  // Name
  show heading.where(level: 1): it => [
    #set align(left)
    #set text(
      weight: 700,
      size: 20pt,
    )
    #pad(it.body)
  ]
  heading(level: 1, name)
  v(5pt)

  // Simple helper function for separator
  let spacer() = {
    h(8pt)
    sym.bar.v
    h(8pt)
  }
  // Intro overview information
  location
  spacer()
  link("mailto:" + email, email)
  spacer()
  link("https://" + git-forge, git-forge)
  spacer()
  link("https://" + work-profile, work-profile)
  spacer()
  link("https://" + homepage, homepage)
  linebreak()

  // Actual page content
  content
}

// Generic two by two component for resume
#let two-by-two(
  top-left: "",
  top-right: "",
  bottom-left: "",
  bottom-right: "",
) = {
  text(weight: 700, top-left) + h(1fr) + top-right
  linebreak()
  text(style: "italic", bottom-left) + h(1fr) + text(style: "italic", bottom-right)
}

// Generic one by two component for resume
#let one-by-two(
  left: "",
  right: "",
) = {
  text(weight: 700, left) + h(1fr) + right
}

#let dates-helper(start, end) = {
  start + " " + sym.dash.em + " " + end
}

#let project(
  title: "",
  url: "",
  dates: "",
) = {
  text(weight: 700, title) + h(8pt) + link("https://" + url, "(" + url + ")") + h(1fr) + dates
}
