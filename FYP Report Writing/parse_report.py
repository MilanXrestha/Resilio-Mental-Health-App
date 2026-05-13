import re

with open('Chapter 4 - Testing and Analysis.md', 'r') as f:
    c4 = f.read()

with open('Appendix.md', 'r') as f:
    app = f.read()

# 1. Extract the test cases we need to move to Appendix.
# Match TC-U006 to TC-U010
u_match = re.search(r'\*\*Table 4\.6: Test Case TC-U006.*?\*\[INSERT FIGURE 4\.10:.*?\]\*', c4, re.DOTALL)
if u_match:
    u_extracted = u_match.group(0)
    c4 = c4.replace(u_extracted, '')
else:
    u_extracted = ""

# Match TC-S006 to TC-S015
s_match = re.search(r'\*\*Table 4\.16: Test Case TC-S006.*?\*\[INSERT FIGURE 4\.25:.*?\]\*', c4, re.DOTALL)
if s_match:
    s_extracted = s_match.group(0)
    c4 = c4.replace(s_extracted, '')
else:
    s_extracted = ""

# Clean up any leftover empty rules or spacing
c4 = re.sub(r'---\n+(?=\n*---)', '', c4)

# 2. Update cross-references in C4
c4 = c4.replace("Ten representative unit test cases", "Five representative unit test cases")
c4 = c4.replace("Fifteen representative system test cases", "Five representative system test cases")

# 3. Replace dashes " — " or " - " with ": "
def remove_ai_dashes(text):
    # Only replace em-dashes and spaced en-dashes when they are used like "Title — Subtitle"
    # To be safe, let's replace " — " and " - " with ": " but preserving Markdown list bullets "- "
    
    # " — " to ": "
    text = text.replace(" — ", ": ")
    
    # " - " to ": " only if it's not a list bullet at start of line
    # (look-behind for not newline/start, or just replace broadly except at start of line)
    lines = text.split('\n')
    for i, line in enumerate(lines):
        # We find spaced dashes that are not the start of bullet points
        # e.g. "Chapter 4 - Testing" -> "Chapter 4: Testing"
        if " - " in line:
            # check if it's not list item " - "
            # if line starts with "- ", it's a list. We want to skip replacing that specifically.
            if line.startswith("- "):
                 # replace instances after the first 2 chars
                 lines[i] = "- " + line[2:].replace(" - ", ": ")
            else:
                 lines[i] = line.replace(" - ", ": ")
    return '\n'.join(lines)


c4 = remove_ai_dashes(c4)
app = remove_ai_dashes(app)

# 4. Append extracted parts to Appendix.md 
# Find a good place, or just put it at the very bottom under a new subsection?
# Actually, the user says "put rest to appendix". Let's put it under Appendix K if possible, or right at the end of the appendix K section.
# Since Appendix K already has tests, let's just append an "ADDITIONAL TEXT EXTRACTED FROM CHAPTER 4" section to K.1 and K.2.

app_lines = app.split('\n')
# We could just put u_extracted after K.1 and s_extracted after K.2

with open('Chapter 4 - Testing and Analysis.md', 'w') as f:
    f.write(c4)

with open('Appendix.md', 'w') as f:
    f.write(app)
    f.write("\n\n---\n")
    f.write("## APPENDIX K (CONTINUED): ADDITIONAL TEST CASES FROM CHAPTER 4\n\n")
    f.write(remove_ai_dashes(u_extracted))
    f.write("\n\n---\n\n")
    f.write(remove_ai_dashes(s_extracted))

print("Script completed!")
