require 'spec_helper'

RSpec.describe 'config/yeti_web.yml' do
  subject do
    Rails.configuration.yeti_web.deep_symbolize_keys
  end

  let(:expected_structure) do
    {
        site_title: be_kind_of(String),
        site_title_image: be_kind_of(String),
        api: {
            token_lifetime: be_kind_of(Integer)
        },
        cdr_export: {
            dir_path: be_kind_of(String),
            delete_url: be_kind_of(String)
        },
        role_policy: {
            when_no_config: be_one_of('allow', 'disallow', 'raise'),
            when_no_policy_class: be_one_of('allow', 'disallow', 'raise')
        }
    }
  end

  it 'has correct structure' do
    # expect(subject).to match(expected_structure)
    expect(subject.keys).to(
        match_array(expected_structure.keys),
        "expected root keys to be #{expected_structure.keys}, but found #{subject.keys}"
    )
    subject.each do |k, v|
      expect(v).to(
          match(expected_structure[k]),
          "expected nested #{k} to match #{expected_structure[k]}, but found #{v}"
      )
    end
  end
end