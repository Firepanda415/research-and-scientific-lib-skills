# Check the argument's consequential links

Select checks relevant to the paper. The purpose is to find unsupported claims or
broken reasoning, not to enforce a fixed limitation/challenge/module sequence.

- **Question to result:** does the stated result answer the motivated question
  under the stated assumptions? A speed claim cannot be supported by accuracy
  evidence alone, and a changed access model may change the question itself.
- **Assumptions to mechanism:** does the method or proof use what the paper
  actually assumes? Resolve a hidden oracle, physical assumption, input condition,
  or approximation if it changes the result.
- **Mechanism to evidence:** do the proof and experiments distinguish the claimed
  behavior? A mechanism suggested by aggregate performance may remain unverified.
- **Evidence to contribution:** is the claim no broader or stronger than the
  evidence? A promised theorem absent from the manuscript is consequential;
  a routine implementation component absent from contribution bullets is not.

For method papers, mapping challenges to components can reveal an unaddressed
obstacle. A many-to-one relation or a supporting component requires no special
justification merely because the counts differ. Repair the explanation or narrow
the claim before inventing architecture to satisfy a table.

Rank findings by effect. A flaw in the central theorem or missing decisive
comparison can be major; a local exposition issue may need only a sentence.
Do not label every chain mismatch critical or block drafting until all cells are
filled. Drafting can itself clarify the surviving argument.
