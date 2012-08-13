 function Wizard(wp) {

    var wizardPages = wp || [],
        currentPage,
        savedState = [];

     this.containsEvent = function() {
         var self = this;
         return !!$($(document).data('events').click)
             .filter(function() {
                 return this.selector == self.template + " .pagination ul li"
             }).size()
     }

    this.bindChangePage = function() {

        var self = this;

        // gambi para nao registrar o evento varias vezes
        if (!this.containsEvent()) {
            $(".pagination ul li", this.template).live('click',function() {
                if (wizardPages[currentPage].onBeforeChangePage(self) === false)
                    return false;
                self.storeState();
                currentPage = $(this).data("order")
                self.renderWizardPage(wizardPages[currentPage]);
            })
        }

    }

    this.storeState = function() {
        savedState[currentPage] = $(this.content, this.template).contents().detach();
    }

    this.restoreState = function() {
        return savedState[currentPage];
    }

    this.draw = function(pageNumber) {
        currentPage = pageNumber || 0;
        $(this.template).data("modal",null);
        var wizardPage = wizardPages[currentPage];
        this.renderWizardPage(wizardPage);
        this.bindChangePage();
        this.show();
    }

    this.show = function() {
        $(this.template).modal("show");
    }

    this.renderWizardPage = function(wizardPage) {
        this.cleanUp();
        $(this.headerContent, this.template).append(wizardPage.header());
        var content = this.restoreState() || wizardPage.content()
        $(this.content, this.template).append(content);
        this.renderPageNumbers();
        wizardPage.onLoad(this);
    }

    this.renderPageNumbers = function() {

        $(wizardPages).each(function(i) {
            $(".pagination ul",this.template).append('<li data-order="'+i+'" ' + (currentPage == i ? 'class="active"' : "") + ' ><a href="#">' + (i + 1) + '</a></li>')
        })

    }

    this.cleanUp = function() {
        $(".cleanup",this.template).empty();
    }

    this.finish = function() {

    }

    this.template = "#load-file-modal";
    this.content = "#load-file-modal-content";
    this.headerContent = "#modal-header-content";
    this.modalFinishButton = "#modal-finish-button";

}

function WizardPage(opts) {
    
    var options = opts

    this.header = function() {
        return this.title() + this.description();
    }
    
    this.title = function() {
        return "<h4>" + options.title + "</h4>";
    }
    
    this.description = function() {
        return "<p>" + options.description + "</p>";
    }
    
    this.content = function() {
        return options.content;
    }

    this.onLoad = function() {
        options.onload && options.onload.apply(this,arguments);
    }

    this.onBeforeChangePage = function() {
        return options.onBeforeChangePage && options.onBeforeChangePage.apply(this,arguments);
    }

}