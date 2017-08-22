module ChatHelper

  def chat_input(question, placeholder=nil)
    { input_html: {"cf-questions" => question,
      "cf-input-placeholder" => placeholder} }
  end

  def chat_radio(question, collection, placeholder=nil)
    # f.input :radio_test, chat_radio("Question", ["Oui", "Non", "Peut-être"])
      {
        input_html: {"cf-questions" => question, "cf-input-placeholder" => placeholder},
        collection: collection,
        as: :radio_buttons
      }
    # {[[1, 'Oui'] ,[2, 'Non'], [3, 'Peut-etre']], :first, :last,
    #   input_html: chat_input("On est parti ?")
  end
end
