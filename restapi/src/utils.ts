export function getErrorMessage(field: string) {
    const response = {
        success: false,
        message: field + ' field is missing or Invalid in the request'
    };
    return response;
}