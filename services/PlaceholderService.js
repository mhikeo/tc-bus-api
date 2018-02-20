/**
 * Service to find email template placeholders name.
 */

const Joi = require('joi')
const config = require('config')
const request = require('superagent')
const cache = require('memory-cache')

/**
 * Get all email template placeholders name.
 *
 * @returns {Array} list with email template placeholders name
 */
async function getAllPlaceholders (name) {
  const cachedData = cache.get(`placeholders-${name}`)
  if (cachedData == null) {
    const data = await request
      .get(`${config.TC_EMAIL_URL}/templates/eventType/${name}`)
      .set('accept', 'json')
      .set('authorization', `Bearer ${config.TC_EMAIL_TOKEN}`)
    const parsedData = JSON.parse(data.text)

    cache.put(`placeholders-${name}`, parsedData, config.TC_EMAIL_CACHE_PERIOD)

    return parsedData
  }

  return cachedData
}

getAllPlaceholders.schema = {
  name: Joi.string().required()
}

/**
 * Clear template placeholder cache.
 */
async function clearAllPlaceholders () {
  cache.clear()
}

module.exports = {
  getAllPlaceholders,
  clearAllPlaceholders
}