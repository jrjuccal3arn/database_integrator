Wizard = (function(){

    var wizardPages = [],
        currentPage;

    function Wizard(wp) {
        wizardPages = wp;
    }

    Wizard.prototype.bindChangePage = function() {
        var self = this;
        $(".pagination ul li").live('click',function() {
            currentPage = $(this).data("order")
            self.renderWizardPage(wizardPages[currentPage]);
        })
    }

    Wizard.prototype.draw = function(pageNumber) {
        currentPage = pageNumber || 0;
        $(this.template).data("modal",null);
        var wizardPage = wizardPages[currentPage];
        this.renderWizardPage(wizardPage);
        this.bindChangePage();
        this.show();
    }

    Wizard.prototype.show = function() {
        $(this.template).modal("show");
    }

    Wizard.prototype.renderWizardPage = function(wizardPage) {
        this.cleanUp();
        $(this.headerContent, this.template).append(wizardPage.header());
        $(this.content, this.template).append(wizardPage.content());
        this.renderPageNumbers();
        wizardPage.onLoad(this);
    }

    Wizard.prototype.renderPageNumbers = function() {

        $(wizardPages).each(function(i) {
            $(".pagination ul",this.template).append('<li data-order="'+i+'" ' + (currentPage == i ? 'class="active"' : "") + ' ><a href="#">' + (i + 1) + '</a></li>')
        })

    }

    Wizard.prototype.cleanUp = function() {
        $(".cleanup",this.template).empty();
    }

    Wizard.prototype.finish = function() {

    }

    Wizard.prototype.template = "#load-file-modal";
    Wizard.prototype.content = "#load-file-modal-content";
    Wizard.prototype.headerContent = "#modal-header-content";
    Wizard.prototype.modalFinishButton = "#modal-finish-button";

    return Wizard;

})()



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
        options.onload.apply(this,arguments);
    }

}