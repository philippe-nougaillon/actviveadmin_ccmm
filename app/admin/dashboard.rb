# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "px-4 py-16 md:py-32 text-center m-auto max-w-3xl" do
      h2 "Bienvenue !", class: "text-base font-semibold leading-7 text-indigo-600 dark:text-indigo-500"
      para "CRM CCMM (Démo)", class: "mt-2 text-3xl sm:text-4xl font-bold text-gray-900 dark:text-gray-200"
      para class: "mt-6 text-xl leading-8 text-gray-700 dark:text-gray-400" do
        text_node "C'est ici que l'on gère les "
        a "Prestations", href: "/admin/prestations"
        text_node ", "
        a "Cotations", href: "/admin/cotations"
        text_node ", Commandes , Factures"
      end
    end
  end
end
