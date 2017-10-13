# Helper method for partial string reversal
# Reverses the character from start_index to end_index
def partial_reverse(my_string, start_index, end_index)
  i = start_index
  j = end_index
  while i < j
    temp = my_string[i] # swap using temporary variable
    my_string[i] = my_string[j]
    my_string[j] = temp
    i += 1
    j -= 1
  end
  return
end

# A method to reverse a string in place.
# Time complexity: O(n) where n is the length of the string.
#       The loop in partial_reverse will get run n/2 times.
# Space complexity: O(1) start_index and end_index are auxiliary storages used
#      Auxiliary storage takes constant space as input string size changes
def string_reverse(my_string)
  start_index = 0
  end_index = my_string.length - 1
  partial_reverse(my_string, start_index, end_index)
  return
end

# A method to reverse each word in a sentence, in place.
# Time complexity: O(n) where n is the length of my_words
# - Each character in my_words gets scanned once to find the beginning and end of
# a word. For this, the characters are compared to the white space, and character
# count is tracked. This takes O(n) time.
# - One the beginning and end for a word is deduced, partial_reverse is called.
# partial_reverse reverses each word and takes O(k) time if there are k characters
# in the word. At the most n characters will get reversed. So, this takes O(n) time.
# - Overall, each character gets visited twice, taking O(2n) time or O(n) time.
# Space complexity: O(1) - the auxiliary storage size does not increase as the
# input length increases.
def reverse_words(my_words)
  i = 0
  length = my_words.length
  while i < length # until end of input
    while my_words[i] == ' ' && i < length # accounting for preceeding spaces
      i += 1
    end
    start_index = i # start of word identified

    while my_words[i] != ' ' && i < length # looking for end of word
      i += 1
    end
    end_index = i - 1 # word ends before the white space or at length-1

    partial_reverse(my_words, start_index, end_index) # reverse the word
  end
  return
end

# A method to reverse the words in a sentence, in place.
# Time complexity: O(n) where n is the number of characters in my_sentence
# - O(n) time to reverse all characters in the sentence. ("Let's go" becomes "og s'teL")
# - O(2n) time to reverse words in the sentence. ("og s'teL" becomes "go Let's")
# - Overall, O(3n) or simplified to O(n)
# Space complexity: O(1) - auxiliary storage used does not depend on input
def reverse_sentence(my_sentence)
  start_index = 0
  end_index = my_sentence.length - 1
  partial_reverse(my_sentence, start_index, end_index) # reverses the whole sentence

  # reverse each word in the sentence
  reverse_words(my_sentence)
end

# A method to check if the input string is a palindrome.
# Return true if the string is a palindrome. Return false otherwise.
# Time complexity: O(n) where n is the length of my_phrase.
# Space complexity: O(1) - auxiliary storage takes constant space as input size changes.
def palindrome_check(my_phrase)
  i = 0
  j = my_phrase.length - 1
  while i < j
    # account for white spaces not counting
    while my_phrase[i] == ' ' && i < j
      i += 1
    end
    while my_phrase[j] == ' ' && i < j
      j -= 1
    end

    if i >= j # check if there is more characters after accounting for white spaces
      break
    end

    if my_phrase[i] != my_phrase[j] # palindrome check
      return false
    end
    i += 1
    j -= 1
  end

  return true # assumes empty string or one letter is a palindrome.
end

# A method that updates the string by replacing consecutive repeating characters
# with a number representing the frequncy. The replacement is done only if the
# string length will get reduced by the process.
# Time complexity: O(n) where n is the number of characters in my_string
# - O(2n) to examine and update character with character followed by count
# - O(n-2) worst case to delete unneeded characters
# Overall, O(n) time.
# Space complexity: O(1) auxiliary storage used for indexing and keeping track of
# current character remains constant as my_string size changes.
def encode_repeating(my_string)
  entering_index = 0 # this is where characters will get replaced
  examining_index = 0 # this is where characters are getting examined and counted
  length = my_string.length
  while examining_index < length # all n characters will be examined
    temp = my_string[examining_index] # current character
    count = 1 # current character count
    while my_string[examining_index+1] == temp && examining_index < length
      examining_index += 1 # increment index
      count += 1 # increment current character count
    end
    # update at entering_index on seeing the subsequent character changing
    if count > 2 # enter the current character followed by it's count
      my_string[entering_index] = my_string[examining_index]
      entering_index += 1
      my_string[entering_index] = count.to_s
      entering_index += 1
    elsif count == 2 # enter the current character twice
      count.times do
        my_string[entering_index] = my_string[examining_index]
        entering_index += 1
      end
    else # count == 1, enter the current character once
      my_string[entering_index] = my_string[examining_index]
      entering_index += 1
    end
    examining_index += 1 # move to next character
  end

  # delete trailing characters in the string.
  count = length - entering_index
  count.times do # worst case: delete n-2 number of characters
    my_string.slice! entering_index # trim the string
  end
  return
end

### ---- END OF METHODS
puts "Test 1: reverse a string"
my_string = "Lovelace"
puts "Original string: #{my_string}"
reversed_string = "ecalevoL"
string_reverse(my_string)
if my_string == reversed_string
  puts "String reversed correctly. Reversed string: #{reversed_string}"
else
  puts "BUG! The reversed string should be '#{reversed_string}' and not '#{my_string}'"
end

puts "Test 2: reversed words"
my_words = "I can be an  engineer"
puts "Original: #{my_words}"
reversed_words = "I nac eb na  reenigne"
reverse_words(my_words)
if my_words == reversed_words
  puts "Words reversed correctly. Reversed words: #{reversed_words}"
else
  puts "BUG! The reversed words should be '#{reversed_words}' and not '#{my_words}'"
end

puts "Test 3: reversed sentence"
sentence = "Yoda  is   awesome"
puts "Original: #{sentence}"
reversed_sentence = "awesome   is  Yoda"
reverse_sentence(sentence)
if sentence == reversed_sentence
  puts "Sentence reversed correctly. Reversed sentence: '#{reversed_sentence}'"
else
  puts "BUG! The reversed sentence should be '#{reversed_sentence}' and not '#{sentence}'"
end

puts "Test 4: Palindrome check"
phrase = "madam"
puts "BUG: madam is a palindrome and should return true" if palindrome_check(phrase) != true
phrase = "empty"
puts "BUG: empty is not a palindrome and should return false" if palindrome_check(phrase) != false
# optional challenge
phrase = "nurses run"
puts "BUG: 'nurses run' is a palindrome and should return true" if palindrome_check(phrase) != true
puts "Palindrome test complete."

# Optional Question #5
puts "Test 5: Encode test"
test1 = "aaabbbbbcccc"
encode_repeating(test1)
if test1 != "a3b5c4"
  puts "BUG! 'aaabbbbbcccc' should get encoded to 'a3b5c4', not '#{test1}'"
end

test2 = "xxxyttttgeee"
encode_repeating(test2)
if test2 != "x3yt4ge3"
  puts "BUG! 'xxxyttttgeee' should get encoded to 'x3yt4ge3', not '#{test2}'"
end

test3 = "ddbbfffgjjjj"
encode_repeating(test3)
if test3 != "ddbbf3gj4"
  puts "BUG! 'ddbbfffgjjjj' should get encoded to 'ddbbf3gj4', not '#{test3}'"
end
puts "Encode test complete."
