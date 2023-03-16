# frozen_string_literal: true

class Cms::FormController < ApplicationController
  before_action :authenticate_user!

  def fields
    category = Category.find_by(id: params[:category_id])
    resource_module = params[:resource_module]
    raise "Invalid resource module" unless Category.stored_attributes[:form_configurations].include?("#{resource_module}_form".to_sym)

    form_fields = "::Types::QueryTypes::#{resource_module.classify}Type".constantize.fields.keys.map(&:underscore)

    # Entferne alle Felder die in einer Kategorie unerwünscht sind
    exclude_fields = []
    exclude_fields = category.send("#{resource_module}_form").select { |_key, value| value == "true" }.keys if category.send("#{resource_module}_form").present?
    form_fields = form_fields - exclude_fields if exclude_fields.any?

    # Entferne alle Felder, die in diesem Model generell unerwünscht sind
    if resource_module.classify.constantize.const_defined?("BLACKLISTED_FORM_FIELDS_FOR_CMS")
      form_fields = form_fields - resource_module.classify.constantize::BLACKLISTED_FORM_FIELDS_FOR_CMS.map(&:to_s)
    end

    exclude_fields_attributes = []
    if exclude_fields.any?
      exclude_fields_attributes = exclude_fields.inject({}) do |hash, element|
        if element.include?("__")
          key, value = element.split("__")
          hash[key] ||= []
          hash[key] << value
        end
        hash
      end
    end

    respond_to do |format|
      format.json do
        return render json: {
          success: true,
          form_fields: form_fields,
          exclude_form_fields: exclude_fields.select{ |field_name| !field_name.include?("__") },
          exclude_form_field_attributes: exclude_fields_attributes
        }
      end
    end
  end
end
