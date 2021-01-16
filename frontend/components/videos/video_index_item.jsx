import React from 'react';
import { Link, Redirect, withRouter } from 'react-router-dom';
import { formatVideoIndexDate } from '../../util/date_util'

const VideoIndexItem = ({ video, user, location, currentUser, openModal, deleteVideo, match }) => {
  debugger
  if (!video) return null;
  let editBtns;
  let videoInfoDiv;
  if (location.pathname === `/channel/${user.id}/videos` && 
    currentUser && video.uploaderId === currentUser.id) {
      editBtns = (
      <>
        <button className="update-btn" onClick={() => openModal('edit')}>Update</button>
        <button className="delete-btn" onClick={() => deleteVideo(video.id)}>Delete</button>
      </>
      )
    } else if (match.path === "/results") {
      videoInfoDiv = (
        <div className="video-info">
          <p className="video-title">{video.title}</p>
          <div className="row">
            <p>123K views</p>
            <i className="dot">•</i>
            <p>{formatVideoIndexDate(video.createdAt, Date.now())}</p>
          </div>
          <Link to={`/channel/${user.id}/featured`} className="channel row">
            <div className="profile-icon">{user.channelName[0]}</div>
            <p>{user.channelName}</p>
          </Link>
          <p>{video.description}</p>
        </div>
      )
    } else {
      editBtns = null
      videoInfoDiv = (
        <div className="video-info">
          {location.pathname.split("/").includes("channel") ?
            null : <Link to={`/channel/${user.id}/featured`}><div className="profile-icon">{user.channelName[0]}</div></Link>}
          <div>
            <p className="video-title">{video.title}</p>
            {/* <Link to={`/channel/${user.id}`}>{user.channelName}</Link> */}
            {location.pathname.split("/").includes("channel") ? 
              null : <Link to={`/channel/${user.id}/featured`}><p>{user.channelName}</p></Link> }
            <div className="row">
              <p>123K views</p>
              <i className="dot">•</i>
              <p>{formatVideoIndexDate(video.createdAt, Date.now())}</p>
            </div>
          </div>
        </div>        
      )
    }
  


  
  return (
    <li>
      <Link to={`/watch/${video.id}`} >  
        <video className="vid-thumbnail" >
          <source src={video.videoUrl} type="video/mp4" />
          Sorry, your browser doesn't support embedded videos.
        </video>
        {videoInfoDiv}
        {editBtns}
      </Link>
    </li>
  )
}

export default VideoIndexItem;