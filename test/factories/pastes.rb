# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :paste do
    code <<-eos
      #include <cstdio>
      using namespace std;

      // nice comment
      int main() {
        return 0;
      }
    eos

    sequence(:slug) { |n| "paste_slug_#{n}" }
  end

  factory :named_paste, :parent => :paste do
    name "solution.cpp"
  end
  
  factory :syntax_paste, :parent => :paste do
    syntax "cpp"
  end
  
  factory :full_paste, :parent => :paste do
    name "solution.php" # funny name...
    syntax "cpp"
  end
end
