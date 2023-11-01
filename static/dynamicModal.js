function showDynamicModal(modalTitle, message, onConfirm, onCancel) {
    // Get modal elements
    const titleElement = document.getElementById('dynamic-confirmation-label');
    const messageElement = document.getElementById('dynamic-modal-message');

    // Populate modal elements
    titleElement.textContent = modalTitle;
    messageElement.textContent = message;

    // Use Bootstrap's modal method to show the modal
    const modal = new bootstrap.Modal(document.getElementById('dynamic-confirmation-modal'));
    modal.show();

    // Set up confirm and cancel button actions
    document.getElementById('confirm-action').onclick = function () {
        modal.hide();
        if (onConfirm) onConfirm();
    }

    document.getElementById('cancel-action').onclick = function () {
        modal.hide();
        if (onCancel) onCancel();
    }
}

export {showDynamicModal}
