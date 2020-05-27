library(devtools)
install_github("computationalstylistics/stylo")

# activating the package 'stylo':
library(stylo)

# creating the word freqquency matrix
# setting a working directory that contains the corpus, e.g.
setwd("/Users/gmikr/Documents/corpus")

# loading the files from a specified directory:
tokenized.texts = load.corpus.and.parse(files = "all", features = "c", ngram.size = 3)

# computing a list of most frequent words (trimmed to top n items):
features = make.frequency.list(tokenized.texts, head = 3000)

# producing a table of relative frequencies:
Impdata = make.table.of.frequencies(tokenized.texts, features, relative = TRUE)

Impdata

rownames(Impdata)

# calculate the decision thresold (two parameters). The lower value is the authorship rejection value and the upper value the authorship acceptance value
imposters.optimize(Impdata, distance="wurzburg")

# getting the nth row from the dataset (it contains frequencies for the book to be tested):
my_text_to_be_tested = Impdata[60,]

# building the reference set so that it does not contain the testing text (and in Ferrante's case all the other books of Ferrante)
my_frequency_table = Impdata[-c(60),]

# launching the imposters method:
imposters(reference.set = my_frequency_table, test = my_text_to_be_tested, distance = "wurzburg")
