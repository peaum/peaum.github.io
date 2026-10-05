# Quarto content

Write blog articles as `.qmd` files in `quarto/blog/posts/`. Write project
case studies as `.qmd` files in `quarto/projects/case-studies/`. The index
pages in those folders automatically list the source documents. Blog posts
sort newest first; project case studies sort by title.

Every document should have at least a `title`, `date`, and `description`.
Blog posts should also include an `author`; both types can include
`categories`. The filename becomes part of the published URL.

Press **Ctrl+Shift+B** in VS Code to run **Build portfolio and Quarto content**.
Quarto renders the documents into `generated/quarto/`; the existing Blog and Projects
links route visitors to the generated listings. Commit the generated output
with the source documents when publishing through GitHub Pages.
