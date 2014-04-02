# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :curricula do
    cur_name 'test-curriculum'
    creator_id '1'
    id '1'
  end

  factory :curricula_2, class: Curricula do
    cur_name 'test-2-curriculum'
    creator_id '2'
  end
end
